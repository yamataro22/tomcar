class ProductsController < ApplicationController
  before_action :logged_in_users, only: [:index, :new, :create, :edit]
  def index
    @categories = Category.all
  end

  def new
    @product = Product.new

    @subcategory_id = params[:subcategory_id]
    @subcategory = Subcategory.find(@subcategory_id)

    if (@subcategory.nil?)
      flash[:danger] = "Niewłaściwa podkategoria"
      redirect_to products_path
    else
      @category = @subcategory.category
    end
  end

  def create
    
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
