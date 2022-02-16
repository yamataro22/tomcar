class ProductsController < ApplicationController
  def index
  end

  def new
    @product = Product.new
    @categories = Category.all
  end

  def edit
  end

  def populate_other_list
    category_id = params[:category_id]
    @subcategory = Subcategory.find_by category_id: category_id
    respond_to do |format|
      format.json { render json: @subcategory }
    end
  end

end
