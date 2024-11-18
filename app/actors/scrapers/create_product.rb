# frozen_string_literal: true

module Scrapers
  class CreateProduct < Actor
    input :scraped_product

    def call
      create_new_product(scraped_product)
    end

    private

    def create_new_product(scraped_product)
      new_product = Product.new(params(scraped_product))
      new_product.image.attach(io: scraped_product[:image], filename: scraped_product[:image_name])
      new_product.save
    end

    def params(scraped_product)
      scraped_product.slice(
        :name, :url_to_shop, :amount, :shop_id, :category_id, :status, :price_in_uah,
        :discount_price_in_uah, :discount_expires_on, :discount_rate, :alcohol_rate
      )
    end
  end
end
