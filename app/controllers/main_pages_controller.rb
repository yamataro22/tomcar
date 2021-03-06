class MainPagesController < ApplicationController
  before_action :logged_in_users, only: [:status]

  def home
    @newest_products = Product.joins(:image_attachment).order(:created_at).last(6)
    @attention = Description.find_by(name: "attention")
  end

  def about
  end

  def help
  end

  def contact
  end

  def author
  end

  def status
    @attention_description = Description.find_by(name: "attention")


    @products = Product.all
    @categories = Category.all
    @subcategories = Subcategory.all

    @counter = 0
    @subcategories.each do |sub|
      if sub.products.count == 0
        @counter += 1
      end
    end
  end
end
