require 'rails_helper'
require 'stripe_mock'

RSpec.describe DonationsController, type: :controller do
  describe 'public stripe methods' do
    before(:each) do
      # mock stripe methods
      Stripe.api_key = 'whateverman'
      @stripe_helper = StripeMock.create_test_helper
    end
    before { StripeMock.start }
    after { StripeMock.stop }

    describe 'POST #charge' do
      it 'creates a charge from the given token' do
        @token = StripeMock.generate_card_token(last4: '9191', exp_year: 1984)
        post :create, amount: 1000, token: @token
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'private stripe methods', live: true do
    before do
      # TODO: find a way to hide this
      Stripe.api_key = 'sk_test_TcKD9GvI1QOcc4Y2sYWqcIBC'

      # token authenticated user
      @resource = FactoryGirl.create(:user)
      @resource.skip_confirmation!
      @resource.save!

      @resource_auth_headers = @resource.create_new_auth_token
    end

    describe 'GET #list_active_subscriptions' do
      it 'responds with a 401 error to unauthorized requests' do
        get :list_active_subscriptions
        expect(response).to have_http_status(401)
      end

      it 'responds successfully to authenticated requests' do
        get :list_active_subscriptions, @resource_auth_headers
        expect(response).to have_http_status(:success)
      end

      it 'lists all customers active subscriptions' do
        get :list_active_subscriptions, @resource_auth_headers
        expect(response).to have_http_status(:success)
        expect(response.headers['Content-Type']).to eq('application/json; charset=utf-8')
        expect(response.body).to include('id')
        expect(response.body).to include('amount')
        expect(response.body).to include('created_at')
        expect(response.body).to include('customer')
      end
    end

    describe 'GET #list_transactions' do
      it 'responds with a 401 error to unauthorized requests' do
        get :list_transactions
        expect(response).to have_http_status(401)
      end

      it 'responds successfully to authenticated requests' do
        get :list_transactions, @resource_auth_headers
        expect(response).to have_http_status(:success)
      end

      it 'lists all customers active subscriptions' do
        get :list_transactions, @resource_auth_headers
        expect(response).to have_http_status(:success)
        expect(response.headers['Content-Type']).to eq('application/json; charset=utf-8')
        expect(response.body).to include('id')
        expect(response.body).to include('amount')
        expect(response.body).to include('created_at')
        expect(response.body).to include('fee')
        expect(response.body).to include('net')
        expect(response.body).to include('available_on')
        expect(response.body).to include('source')
        expect(response.body).to include('type')
      end
    end

    describe 'GET #list_customers' do
      it 'responds with a 401 error to unauthorized requests' do
        get :list_customers
        expect(response).to have_http_status(401)
      end

      it 'responds successfully to authenticated requests' do
        get :list_customers, @resource_auth_headers
        expect(response).to have_http_status(:success)
      end

      it 'lists all customers active subscriptions' do
        get :list_customers, @resource_auth_headers
        expect(response).to have_http_status(:success)
        expect(response.headers['Content-Type']).to eq('application/json; charset=utf-8')
        expect(response.body).to include('id')
        expect(response.body).to include('email')
        expect(response.body).to include('created_at')
        expect(response.body).to include('subscriptions')
      end
    end
  end
end
