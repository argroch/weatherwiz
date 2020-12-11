Rails.application.routes.draw do
  root 'home#index'
  post 'weather_check', to: 'home#weather_check'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
