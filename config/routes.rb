Rails.application.routes.draw do
  root to: redirect('/bands')
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:show, :new, :create]
  resources :bands do
    resources :albums, only: [:new]
  end
  resources :albums, only: [:update, :show, :create, :destroy, :edit]
end
