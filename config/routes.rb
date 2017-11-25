Rails.application.routes.draw do
  resources :sensors, only: [:update]
  resources :sumps, only: [:index, :show]

  post '/sigfox/data', to: 'sigfox#data'
end
