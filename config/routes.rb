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

    root to: 'pages#dashboard'
  end

  namespace :api do
    namespace :store do
      resources :purchases
    end
  end

  namespace :store do
    resources :products, only: [:index, :show]
  end

  root to: 'store/products#index'

  # Exceptions routing
  get '/404', to: 'errors#not_found'
  get '422',  to: 'errors#unacceptable'
  get '/500', to: 'errors#internal_error'
end
