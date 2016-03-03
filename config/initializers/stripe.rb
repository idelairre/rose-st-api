module Serialization
  extend ActiveModel::Naming
  include ActiveModel::Serialization
end

Stripe::StripeObject.class_eval do
  include Serialization
end

Rails.configuration.stripe = {
  :secret_key => ENV['SECRET_KEY']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
