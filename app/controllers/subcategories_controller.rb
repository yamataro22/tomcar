class SubcategoriesController < ApplicationController
  before_action :logged_in_users, only: [:update, :index, :create, :edit, :destroy]

  def index
    @categories = Category.all
    @subcategories = Subcategory.all
    @subcategory = Subcategory.new
  end

  def create
    @subcategory = Subcategory.new(subcategory_params)
    if @subcategory.save
      flash[:success] = "Kategoria stworzona!"
      redirect_to subcategories_path
    else
      @subcategories = Subcategory.all
      render 'index'
    end
  end

  def destroy
    subcategory = Subcategory.find(params[:id]).destroy
    flash[:info] = "Podkategoria usunięta"
    redirect_to subcategories_path
  end

  def edit
    @subcategory = Subcategory.find(params[:id])
  end

  def update
    @subcategory = Subcategory.find(params[:id])

    if @subcategory.nil?
      flash[:danger] = "Próba edycji nieistniejącej kategori."
      redirect_to root_url
    end

    if (@subcategory.update(subcategory_params))
      flash[:success] = "Nazwa zmieniona"
      redirect_to subcategories_path
    else
      render 'edit'
    end
  end

private 
    
  def subcategory_params
    params.require(:subcategory).permit(:name)
  end

end

