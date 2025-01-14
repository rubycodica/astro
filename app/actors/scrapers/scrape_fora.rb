# frozen_string_literal: true

module Scrapers
  class ScrapeFora < Actor
    AVAILABLE = Product.statuses.key(0)
    OUT_OF_STOCK = Product.statuses.key(1)
    CITY = 'м. Київ'
    STREET = 'вул. Печенізька, 1/7а'

    input :endpoints

    def call
      scrape_products(endpoints)
    end

    private

    def scrape_products(endpoints)
      endpoints.each do |endpoint|
        main_window = Watir::Browser.new :firefox, headless: true
        additional_window = Watir::Browser.new :firefox, headless: true

        main_window.goto(endpoint.url)
        additional_window.goto(endpoint.url)

        select_local_store(main_window)
        select_local_store(additional_window)

        loop do
          sleep 3
          products_in_divs = main_window.ul(class: 'product-list').children.to_a
          products_in_divs.delete_if { |d| d.class_name.include?('special-proposals-wrapper') }

          proceed(additional_window, products_in_divs, endpoint)

          break if main_window.div(class: 'pagination-link next disabled').present?

          main_window.div(class: 'pagination-link next').scroll.to
          main_window.div(class: 'pagination-link next').click
        end
        additional_window.close
        main_window.close
      rescue StandardError => e
        Rails.logger.error e
        additional_window&.close
        main_window&.close
      end
    end

    def select_local_store(window)
      window.li(class: 'location').click
      sleep 3
      window.div(class: 'button-switch-item', text: 'Самовивіз').click
      sleep 3
      window.is(class: 'icon-cross')[1].click
      sleep 1
      window.input(class: 'store-select__city').click
      sleep 1
      window.div(class: 'store-select__autocomplete-item', text: CITY).click
      sleep 1
      if window.is(class: 'icon-cross').count.eql?(2)
        window.input(class: 'store-select__store').click
        sleep 1
        window.div(class: 'store-select__autocomplete-item', text: STREET).click
        sleep 1
      end
      sleep 3
      window.a(class: 'btn btn-primary', text: 'Обрати супермаркет').click
    end

    def proceed(additional_window, products_in_divs, endpoint)
      products_in_divs.each do |div|
        next if div.button(text: 'Переглянути').present?

        product = {}

        product[:url_to_shop] = div.a(class: 'image-content-wrapper').href.split('?').first

        assign_status(product, div)

        existing_product = Product.find_by(url_to_shop: product[:url_to_shop])

        next if existing_product&.status.eql?(product[:status]) && product[:status].eql?(OUT_OF_STOCK)

        assign_price(product, div) unless product[:status].eql?(OUT_OF_STOCK)

        if existing_product
          ::Scrapers::UpdateProduct.call(scraped_product: product, existing_product: existing_product)
        else
          next if product[:status].eql?(OUT_OF_STOCK)
          next if scrape_additionally_for_new_product(additional_window, product).blank?

          product[:name] = div.div(class: 'product-title').text.tr('«»®?', '')
          product[:amount] = div.div(class: 'product-weight').text
          product[:shop_id] = endpoint.shop.id
          product[:category_id] = endpoint.category.id
          ::Scrapers::CreateProduct.call(scraped_product: product)
        end
      end
    end

    def assign_status(product, div)
      product[:status] = if div.class_name.include?('not-available')
                           OUT_OF_STOCK
                         else
                           AVAILABLE
                         end
    end

    def assign_price(product, div)
      current_price = "#{div.div(class: 'current-integer').text}.#{div.div(class: 'current-fraction').text}".to_f

      product[:price_in_uah] = if div.div(class: 'old-price').present?
                                 div.div(class: 'old-integer').text.tr(',', '.').to_f
                               else
                                 current_price
                               end

      assign_discount(product, div, current_price) if div.div(class: 'discount-count').present?
    end

    def assign_discount(product, div, current_price)
      product[:discount_rate] = div.div(class: 'discount-count').text.to_i.abs
      product[:discount_expires_on] = Date.strptime(div.div(class: 'product-promotion-period')
                                          .span.inner_html.split.last, '%d.%m.%Y')

      product[:discount_price_in_uah] = current_price
    end

    def scrape_additionally_for_new_product(additional_window, product)
      additional_window.goto(product[:url_to_shop])

      return false if scrape_image(additional_window, product).blank?

      if additional_window.div(text: '% спирту').present?
        product[:alcohol_rate] = additional_window.div(text: '% спирту').parent.divs[1].text.to_f
      end

      true
    rescue StandardError => e
      Rails.logger.error e
      false
    end

    def scrape_image(additional_window, product)
      retries = 3
      loop do
        sleep 3
        src = additional_window.div(class: 'product-preview_carousel').img.src
        return false if src.include?('no_photo')

        product[:image] = URI.parse(src).open
        retries -= 1
        break if product[:image].is_a?(Tempfile) || retries.zero?
      end
      return false if retries.zero?

      raw_image_name = product[:url_to_shop].split('/')[4].split('-')
      raw_image_name.pop
      product[:image_name] = "#{raw_image_name.join('-')}.png"
    end
  end
end
