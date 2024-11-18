# frozen_string_literal: true

module Scrapers
  class UpdateProduct < Actor
    input :scraped_product
    input :existing_product

    def call
      update_existing_product(scraped_product, existing_product)
    end

    private

    def update_existing_product(scraped_product, existing_product)
      scraped_product_for_update = params(scraped_product)

      scraped_product_for_update.each do |key, value|
        next if existing_product.send(key).eql?(value)

        return existing_product.update(scraped_product_for_update)
      end
    end

    def params(scraped_product)
      scraped_product.slice(
        :status, :price_in_uah, :discount_price_in_uah, :discount_expires_on, :discount_rate
      )
    end
  end
end
