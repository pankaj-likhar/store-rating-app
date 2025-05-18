Rails.application.routes.draw do
  devise_for :users
  
  get 'admin/dashboard', to: 'admin#dashboard'
  
  resources :stores do
    resources :ratings, only: [:create, :edit, :update]
  end
  
  resources :users, except: [:index, :show]
  
  root 'stores#index'
end
