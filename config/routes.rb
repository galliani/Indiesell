Rails.application.routes.draw do
  namespace :admin do
    controller :pages do
      get :dashboard
    end

    resources :products do
      member do
        delete :display_picture,  action: :remove_display_picture
        delete :images,           action: :remove_image
      end
    end
    resources :purchases, only: [:index, :show]

    root to: 'pages#dashboard'
  end

  namespace :api do
    namespace :v1 do
      namespace :store do
        resources :paypal_purchases, only: [:create] do
        end
      end
    end
  end

  namespace :store do
    resources :products, only: [:index, :show]
    resources :purchases, only: [] do
      collection do
        get :failure
      end
      member do
        get :success
      end
    end
  end

  root to: 'store/products#index'

  # Exceptions routing
  get '/404', to: 'errors#not_found'
  get '422',  to: 'errors#unacceptable'
  get '/500', to: 'errors#internal_error'
end
