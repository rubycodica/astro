# frozen_string_literal: true

class Product < ApplicationRecord
  enum :status, { available: 0, out_of_stock: 1 }, default: :available

  belongs_to :shop
  belongs_to :category

  has_one_attached :image

  validates :name, :amount, :price, presence: true
  validates :url_to_shop, presence: true, uniqueness: true

  def price_in_uah
    price.to_f / 100
  end

  def price_in_uah=(uah)
    self.price = (uah * 100).to_i
  end

  def discount_price_in_uah
    discount_price&.to_f&./ 100
  end

  def discount_price_in_uah=(uah)
    self.discount_price = (uah * 100).to_i
  end

  def on_sale?
    return false if discount_expires_on.blank?

    discount_expires_on >= Date.current
  end
end
