class SubcategoriesController < ApplicationController
  before_action :logged_in_users, only: [:update, :index, :create, :edit, :destroy]

  def index
    redirect_to categories_path
  end

  def create

    @category = Category.find_by(name: subcategory_params[:category])
    @subcategory = @category.subcategories.build(name: subcategory_params[:name])

    if @subcategory.save
      flash[:success] = "Podkategoria stworzona!"
    else
      flash[:warning] = "Nie udało sie stworzyć podkategorii"
    end
    redirect_to categories_path
  end

  def destroy
    subcategory = Subcategory.find(params[:id]).destroy
    flash[:info] = "Podkategoria usunięta"
    redirect_to categories_path
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
      redirect_to categories_path
    else
      render 'edit'
    end
  end

private 
    
  def subcategory_params
    params.require(:subcategory).permit(:name, :category)
  end

end

