Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do

      resources :users
      resources :movies, only: [:index, :show, :create, :update, :destroy]
      resources :actors, only: [:show, :index]
      resources :directors, only: [:show, :index]

      get '/search', to: 'static#search'
    end
  end
end
