FrenchPrint::Application.routes.draw do
  devise_for :users, :controllers => {:registrations => "users/registrations"}

  root to: "application_controller#index"

  namespace :admin do
    get "/" => "home#index"

    resources :articles, only: [:index, :destroy]
    resources :artworks, only: [:index, :destroy]
    resources :subjects, only: [:destroy]

    resources :galleries do
      resources :exhibitions
    end

    resources :people do
      resources :roles
      resources :artworks, only: [:new, :edit, :show, :create, :update]
      resources :articles, only: [:new, :edit, :show, :create, :update]
    end

    resources :journals do
      resources :personnel_histories
    end
  end
end
