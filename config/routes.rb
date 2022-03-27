Rails.application.routes.draw do
  devise_for :users
  resources :courses
  root 'pages#index'
  get 'privacy_and_terms', to: 'pages#privacy_terms'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
