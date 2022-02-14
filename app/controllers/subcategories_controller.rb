class SubcategoriesController < ApplicationController

  def index
    @subcategories = Subcategory.all
  end

  def create
    @subcategory = Subcategory.new(subcategory_params)
    if @subcategory.save
      flash[:success] = "Kategoria stworzona!"
      redirect_to subcategories_path
    else
      @subcategories = Subcategory.all
      flash.now[:danger] = "Nie udało się stworzyć nowej kategorii"
      render 'index'
    end
  end

  def destroy
    subcategory = Subcategory.find(params[:id]).destroy
    flash[:info] = "Podkategoria usunięta"
    redirect_to subcategories_path
  end

private 
    
  def subcategory_params
    params.require(:subcategory).permit(:name)
  end

end
