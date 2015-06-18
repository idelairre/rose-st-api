Rails.application.routes.draw do
  resources :charges do
    post '/subscription', to: 'charges#subscription', on: :collection
    post '/custom_subscription', to: 'charges#custom_subscription', on: :collection
  end
  resources :posts
  resources :users, defaults: { format: :json } do
    get '/login', to: 'users#login', on: :collection
    post '/login', to: 'users#login', on: :collection
    post '/logout', to: 'users#logout', on: :collection
  end
end
