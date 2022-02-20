Rails.application.routes.draw do

  get 'categories/index'
  root 'main_pages#home'
  get  'main_pages/home'
  get  'main_pages/about'
  get  'main_pages/help'
  get  'main_pages/contact'

  get  'login'     => 'sessions#new'
  post 'login'     => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  resources :subcategories, only: [:create, :destroy, :edit, :update]
  resources :categories, only: [:index, :create, :destroy, :edit, :update]
  resources :products, only: [:destroy, :show, :index, :create, :new, :edit]
end
