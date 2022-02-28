Rails.application.routes.draw do

  get 'catalog/index'
  get 'categories/index'
  root 'main_pages#home'
  get  'main_pages/home'
  get  'main_pages/about'
  get  'main_pages/help'
  get  'main_pages/contact'
  get  'main_pages/author'
  get  'main_pages/status'

  get  'login'     => 'sessions#new'
  post 'login'     => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  get 'katalog'  => 'catalog#index'

  resources :subcategories, only: [:show, :create, :destroy, :edit, :update]
  resources :categories, only: [:index, :create, :destroy, :edit, :update]
  resources :products, only: [:destroy, :show, :index, :create, :new, :edit]
  resources :descriptions, only: [:new, :create, :update, :destroy]
end
