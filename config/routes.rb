Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)

  root to: "admin/dashboard#index"

  namespace :api do
    resources :subscriptions, only: [:create]
  end
end
