Rails.application.routes.draw do
  devise_for :admin_users, skip: [:registrations]
  
  # Admin namespace
  namespace :admin do
    root to: "dashboard#index"
    resources :posts
    resources :campu
    resources :inquiries do
      patch :mark_contacted, on: :member
    end
  end
  
  # ... rest of your routes (public ones)
  get "inquiries/new"
  get "inquiries/create"
  get "pages/home"
  get "up" => "rails/health#show", as: :rails_health_check
  resources :inquiries, only: [:new, :create]
  get '/admissions', to: 'inquiries#new'
  root "pages#home"
end