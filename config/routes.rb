Rails.application.routes.draw do
  root "products#index"
  devise_for :administrators, controllers: { sessions: 'admins/sessions' }
  devise_for :users, controllers: { sessions: 'users/sessions' }

  namespace :admin do
    resources :products, except: [:show]
  end

  resources :products, only: [:index, :show] do
    collection do
      get 'search'
    end
  end

  resources :categories, only: [:index, :show]
  get 'admin_dashboard', to: 'admin_dashboard#index'

  resource :cart, only: [:show] do
    post 'add', to: 'cart#add', as: 'add_to'
    delete 'remove', to: 'cart#remove', as: 'remove_from'
  end
end