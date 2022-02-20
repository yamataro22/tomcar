class ProductsController < ApplicationController
  before_action :logged_in_users
  def index
    @categories = Category.all
  end

  def new
    @subcategory_id = params[:subcategory_id]
    @subcategory = Subcategory.find(@subcategory_id)

    @product = @subcategory.products.build

    if (@subcategory.nil?)
      flash[:danger] = "Niewłaściwa podkategoria"
      redirect_to products_path
    else
      @category = @subcategory.category
    end
  end

  def create
    cat_id = products_params[:subcategory_id]
    @subcategory = Subcategory.find(cat_id)

    @product = @subcategory.products.build(products_params)

    if @product.save
      flash[:success] = "Udało się stworzyć produkt"
      redirect_to @product
    else
      render 'new', subcategory_id: cat_id
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
  end

  def destroy
    Product.find(params[:id]).destroy
    flash[:success] = "Produkt usunięty"
    redirect_to products_path
  end

  def populate_other_list
    category_id = params[:category_id]
    @subcategory = Subcategory.find_by category_id: category_id
    respond_to do |format|
      format.json { render json: @subcategory }
    end
  end

private

  def products_params
    params.require(:product).permit(:name, 
                                    :subcategory_id,
                                    :short_description,
                                    :long_description,
                                    :price)

  end

end
