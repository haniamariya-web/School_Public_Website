Rails.application.routes.draw do
  devise_for :admin_users, skip: [:registrations], controllers: {
    sessions: 'admin/sessions'
  }
  
  namespace :admin do
    root to: "dashboard#index"
    resources :posts do
      member do
        delete :remove_image
        delete :remove_video
      end
    end
    resources :campu
    resources :inquiries do
      patch :mark_contacted, on: :member
    end
    resources :albums do
      member do
        post :add_post
        delete :remove_post
      end
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