require 'rails_helper'

RSpec.describe Donation, type: :model do
  before { StripeMock.start }
  after { StripeMock.stop }
  before do
    Stripe.api_key = 'whateverman'
    @stripe_helper = StripeMock.create_test_helper
  end
  describe 'Stripe' do
    it 'creates a stripe customer' do
      customer = Stripe::Customer.create(email: 'johnny@appleseed.com', card: @stripe_helper.generate_card_token)
      expect(customer.email).to eq('johnny@appleseed.com')
    end
    it 'generates a stripe card token' do
      card_token = StripeMock.generate_card_token(last4: '9191', exp_year: 1984)
      cus = Stripe::Customer.create(source: card_token)
      card = cus.sources.data.first
      expect(card.last4).to eq('9191')
      expect(card.exp_year).to eq(1984)
    end
    it 'mocks a declined card error' do
      StripeMock.prepare_card_error(:card_declined)
      expect { Stripe::Charge.create(amount: 1, currency: 'usd') }.to raise_error {|e|
        expect(e).to be_a Stripe::CardError
        expect(e.http_status).to eq(402)
        expect(e.code).to eq('card_declined')
      }
    end
  end
end
