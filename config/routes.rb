Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  resources :donations, only: [:create] do
    collection do
      post '/subscription', to: 'donations#subscription'
      post '/custom_subscription', to: 'donations#custom_subscription'
      get '/charges', to: 'donations#list_charges'
      get '/customers', to: 'donations#list_customers'
      get '/customers/:customer_id/subscriptions/', to: 'donations#list_customer_subscriptions'
      get '/subscriptions/', to: 'donations#list_active_subscriptions'
      get '/transactions/', to: 'donations#list_transactions'
    end
  end
  resources :messages, only: [:index, :create, :destroy], defaults: { format: :json }
  resources :posts, only: [:index, :update, :destroy, :create], defaults: { format: :json } do
    get '/:title_url', to: 'posts#show', on: :collection
  end
  resources :users, only: [:index, :show, :update, :destroy, :create], defaults: { format: :json }
end
