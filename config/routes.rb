Rails.application.routes.draw do
  resources :charges
  resources :posts
  resources :users, defaults: { format: :json } do
    get '/login', to: 'users#login', on: :collection
    post '/login', to: 'users#login', on: :collection
    post '/logout', to: 'users#logout', on: :collection
  end
end
