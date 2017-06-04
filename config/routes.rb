Rails.application.routes.draw do
  mount ActionCable.server => "/cable"

  get "pages/:page", to: "pages#show", as: "page"
  root "pages#show", page: "home"

  devise_for :users, controllers: {registrations: "users/registrations"}

  devise_scope :user do
    get "/signup", to: "users/registrations#new"
    post "/signup", to: "users/registrations#create"
    get "/login", to: "devise/sessions#new"
    post "/login", to: "devise/sessions#create"
    delete "/logout", to: "devise/sessions#destroy"
  end

  resources :groups, except: :destroy
  resources :users, except: [:index, :destroy]
  resources :group_users, only: [:create, :destroy]
  resources :reports, only: [:create, :index]
end
