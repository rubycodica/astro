# frozen_string_literal: true

class Endpoint < ApplicationRecord
  belongs_to :shop
  belongs_to :category

  validates :url, presence: true, uniqueness: true
end
