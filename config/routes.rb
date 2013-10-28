FrenchPrint::Application.routes.draw do
  devise_for :users, :controllers => {:registrations => "users/registrations"}

  root to: "application_controller#index"

  namespace :admin do
    resources :people do
      resources :roles
      resources :artworks
    end

    resources :journals do
      resources :personnel_histories
    end
  end
end
