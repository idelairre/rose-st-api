require 'rails_helper'
require 'spec_helper'
require 'stripe_mock'

RSpec.describe 'Charge request', type: :request, :live => true do
  let(:stripe_helper) { StripeMock.create_test_helper }
  before(:each) do
    Stripe.api_key = 'sk_test_TcKD9GvI1QOcc4Y2sYWqcIBC'
    StripeMock.spawn_server
  end
  before do
    @client = StripeMock.start_client
  end
  after { StripeMock.stop_client(:clear_server_data => true) }
  it 'creates a charge' do
    expect(Donation.all.count).to eq(0)
    post '/donations', "{ amount: 10000, token: #{stripe_helper.generate_card_token} }"
    expect(response).to have_http_status(200)
    expect(Donation.all.count).to eq(1)
    # charge = Stripe::Charge.create(amount: 1000, currency: 'usd', card: stripe_helper.generate_card_token)
  end
  # it 'gets customer data' do
  #   StripeMock.start_client
  #   customer = Stripe::Customer.create(email: 'johnny@appleseed.com', card: stripe_helper.generate_card_token)
  #   server_customer_data = @client.get_server_data(:customers)[customer.id]
  #   expect(server_customer_data).to_not be_nil
  #   expect(server_customer_data[:email]).to eq('johnny@appleseed.com')
  # end
end
