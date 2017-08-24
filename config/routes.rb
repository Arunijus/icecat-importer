Rails.application.routes.draw do
  root 'importer#index'

  get 'importer/index'
  get '/products' => 'products#index', as: :products
  get '/products/edit/:id' => 'products#edit', as: :edit_product
  get '/products/show/:id' => 'products#show', as: :show_product

  post '/products/update/:id' => 'products#update', as: :update_product
end
