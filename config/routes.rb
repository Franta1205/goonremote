Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "jobs#index"

  resources :companies, only: %i[index new create show edit update] do
    collection do
      get :your_companies
    end
  end
  resources :jobs do
    collection do
      get :remote_jobs
      get :pending_jobs
    end
  end

  resources :dashboard

  authenticated :user do
    get "settings", to: "users#settings", as: :user_settings
    post "subscribe", to: "users#subscribe", as: :subscribe
  end
end
