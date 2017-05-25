Rails.application.routes.draw do
  get 'importer/index'

  root 'importer#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
