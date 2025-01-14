# frozen_string_literal: true

class ProductsController < ApplicationController
  def index
    @products = Product.includes(image_attachment: :blob).limit(12)
  end

  def show
    @product = Product.find(params[:id])
  end
end
