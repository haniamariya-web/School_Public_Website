Rails.application.routes.draw do
  devise_for :admin_users, skip: [ :registrations ], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    root to: "dashboard#index"

    resources :posts do
      member do
        delete :remove_media
      end
    end


    resources :news, except: [ :show ] do
      member do
        delete :remove_media
      end
    end

    resources :campu
    resources :inquiries do
      patch :mark_contacted, on: :member
    end
    resources :franchise_applications, only: [:index, :show, :update]
    resources :albums do
      member do
        post :add_post
        delete :remove_post
      end
    end
  end

  # Public routes
  get "gallery", to: "gallery#index"
  get "gallery/album/:id", to: "gallery#show", as: :gallery_album
  get "about", to: "pages#about"
  get "campuses", to: "campuses#index"
  resources :news, only: [ :index ]
  get "up" => "rails/health#show", as: :rails_health_check

  get "buy-franchise", to: "franchise_applications#new"
  post "franchise_applications", to: "franchise_applications#create"
  get "franchise_applications/success", to: "franchise_applications#success"
  get "franchise_applications/cancel", to: "franchise_applications#cancel"
  get "franchise_payment", to: "franchise_applications#payment"

  post "/stripe/webhooks", to: "webhooks#stripe"

  resources :inquiries, only: [ :new, :create ]
  get "/admissions", to: "inquiries#new"

  root "pages#home"
end
