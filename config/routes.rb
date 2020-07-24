Rails.application.routes.draw do
  root to: 'power_generators#index'
  post '/', to: 'power_generators#index'
  resources :home, only: %i[index]

  resource :power_generators, only: [:show, :update]
  resources :freights, only: %i[index]
end
