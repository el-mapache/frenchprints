FrenchPrint::Application.routes.draw do

  devise_for :users, :controllers => {:registrations => "users/registrations"}

  root to: "application_controller#index"

  namespace :admin do
    get "/" => "home#index"

    resources :articles, only: [:index, :destroy]
    resources :artworks, only: [:index, :destroy]

    resources :people do
      resources :roles
      resources :artworks, only: [:new, :edit, :create, :update]
      resources :articles, only: [:new, :edit, :create, :update]
    end

    resources :journals do
      resources :personnel_histories
    end
  end
end
