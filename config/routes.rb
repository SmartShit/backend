Rails.application.routes.draw do
  resources :sumps, only: [:index, :show]

  get '/sigfox/data', to: 'sigfox#data'
  get '/route', to: 'route#route'
end

# GET /sumps
# GET /sumps/$id
# GET /route