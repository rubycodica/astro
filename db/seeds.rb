# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

ApplicationRecord.transaction do
  shop = Shop.create!(name: 'Фора')

  category = Category.create!(name: 'Хліб та випічка')

  subcategory = Category.create!(name: 'Хлібобулочні вироби', parent: category)

  subsubcategory = Category.create!(name: 'Хліб', parent: subcategory)

  Endpoint.create!(url: 'https://fora.ua/category/khlib-2912', shop: shop, category: subsubcategory)
end
