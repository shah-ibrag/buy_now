Rails.application.routes.draw do
  root "products#index"
  devise_for :admins
  resources :products, only: [:index, :show] do
    collection do
      get 'search'
    end
  end
  resources :categories, only: [:index, :show]
  get 'admin_dashboard', to: 'admin_dashboard#index'
end