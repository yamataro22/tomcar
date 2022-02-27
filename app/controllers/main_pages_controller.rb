class MainPagesController < ApplicationController
  before_action :logged_in_users, only: [:status]

  def home
    @newest_products = Product.joins(:image_attachment).order(:created_at).last(6)
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
  end
end
