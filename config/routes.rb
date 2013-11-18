FrenchPrint::Application.routes.draw do
  devise_for :users, :controllers => {:registrations => "users/registrations"}

  root to: "application_controller#index"

  namespace :admin do
    get "/" => "home#index"

    resources :articles, only: [:index, :destroy]
    resources :artworks, only: [:index, :destroy]
    resources :subjects, only: [:destroy]
    resources :personnel_histories

    resources :exhibitions, only: [:index, :destroy, :show]

    resources :galleries do
      resources :exhibitions, only: [:create, :update, :edit, :new]
    end

    resources :people do
      resources :roles
      resources :artworks, only: [:new, :edit, :show, :create, :update]
      resources :articles, only: [:new, :edit, :show, :create, :update]
      resources :representations, only: [:new, :create, :destroy]
    end

    resources :journals
  end
end
