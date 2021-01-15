Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  get 'log_in', to: 'home#log_in'
  get 'wthr_chk', to: 'home#weather_check'
  post 'weather_check', to: 'home#weather_check'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
