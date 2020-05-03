Rails.application.routes.draw do
  root to: 'recipes#index'
  
  get 'signup', to: 'users#new'
  resources :users, except: [:new]
  
  resources :recipes
end
