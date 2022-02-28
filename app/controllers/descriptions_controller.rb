class DescriptionsController < ApplicationController
  def new
    @description = Description.new
  end

  def create
     @description = Description.new(description_params) 
     if @description.save
      flash[:success] = "Stworzono opis na stronę główną"
      redirect_to main_pages_status_path 
     else
      render 'new'
     end
  end

  def update
  end

  def destroy
    @description = Description.find(params[:id]).destroy
    flash[:success] = "Udało się usunąć ogłoszenie"
    redirect_to root_path
  end

private
  def description_params
    params.require(:description).permit(:name, :content)
  end
end
