Rails.application.routes.draw do

  get 'catalog/index'
  get 'categories/index'
  root 'main_pages#home'
  get  'main_pages/home'
  get  'main_pages/about'
  get  'main_pages/help'
  get  'main_pages/contact'

  get  'login'     => 'sessions#new'
  post 'login'     => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  get 'katalog'  => 'catalog#index'

  resources :subcategories, only: [:create, :destroy, :edit, :update]
  resources :categories, only: [:index, :create, :destroy, :edit, :update]
  resources :products, only: [:destroy, :show, :index, :create, :new, :edit]
end
