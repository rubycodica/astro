# frozen_string_literal: true

class Shop < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensative: false }
end
