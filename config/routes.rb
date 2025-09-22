Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }

  root 'products#index'

  resources :products, only: %i[index show]

  namespace :seller_users do
    resources :products, only: %i[new edit create update destroy]
    resources :progressing_trades, only: %i[index show update]
    resources :completed_trades, only: %i[index show]
  end

  namespace :buyer_users do
    resources :progressing_trades, only: %i[index show create update]
    resources :completed_trades, only: %i[index show]
  end

  get 'up' => 'rails/health#show', as: :rails_health_check
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
