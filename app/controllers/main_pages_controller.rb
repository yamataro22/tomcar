class MainPagesController < ApplicationController
  def home
    @newest_products = Product.joins(:image_attachment).order(:created_at).last(6)
  end

  def about
  end

  def help
  end

  def contact
  end
end
