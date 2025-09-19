Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }

  root 'products#index'

  resources :products, only: %i[index show]

  namespace :seller_users do
    resources :products, only: %i[new edit create update destroy]
  end

  namespace :buyer_users do
    resources :trades, only: %i[index show create]
  end

  get 'up' => 'rails/health#show', as: :rails_health_check
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
