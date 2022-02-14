class CategoriesController < ApplicationController
  before_action :logged_in_users, only: [:update, :index, :create, :edit, :destroy]

  def index
    @categories = Category.all
    @category = Category.new
    @subcategory = Subcategory.new
  end

  def create
    @category = Category.new(category_params)
    @subcategory = Subcategory.new

    if @category.save
      flash[:success] = "Kategoria stworzona!"
      redirect_to categories_path
    else
      @categories = Category.all
      render 'index'
    end
  end

  def destroy
    category = Category.find(params[:id]).destroy
    flash[:info] = "Kategoria usunięta"
    redirect_to categories_path
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])

    if @category.nil?
      flash[:danger] = "Próba edycji nieistniejącej kategori."
      redirect_to root_url
    end

    if (@category.update(category_params))
      flash[:success] = "Nazwa zmieniona"
      redirect_to categories_path
    else
      render 'edit'
    end
  end

private 
    
  def category_params
    params.require(:category).permit(:name)
  end


end
