Rails.application.routes.draw do
  namespace :admin do
    controller :pages do
      get :dashboard
    end

    resources :products
  end
  namespace :store do
    # resources :products
  end

  root to: 'admin/pages#dashboard'

  # Exceptions routing
  get '/404', to: 'errors#not_found'
  get '422',  to: 'errors#unacceptable'
  get '/500', to: 'errors#internal_error'
end
