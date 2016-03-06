require 'rails_helper'
require 'spec_helper'

RSpec.describe 'Auth/user routes', type: :request do
  before(:all) do
    @redirect_url = 'http://ng-token-auth.dev'
  end
  describe 'POST /auth' do
    it 'creates a user' do
      prev_users = User.all.count
      post '/auth', FactoryGirl.attributes_for(:user, confirm_success_url: @redirect_url)
      expect(response).to have_http_status(200)
      expect(User.all.count).to eq(prev_users + 1)
    end

    it 'sends a confirmation email' do
      expect { post '/auth', FactoryGirl.attributes_for(:user, confirm_success_url: @redirect_url) }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end

  describe 'POST /auth/password' do
    it 'sends an email with a password reset token' do
      user = FactoryGirl.create(:user)
      expect { post '/auth/password', redirect_url: @redirect_url, email: user.email }.to change { ActionMailer::Base.deliveries.count }.by(1)
      expect(response).to have_http_status(200)
      mail = ActionMailer::Base.deliveries.last.to_s
      expect(mail).to match(/(?<=Token: )(.*)(?=<\/p>)/)
      @token = /(?<=Token: )(.*)(?=<\/p>)/.match(mail)
    end
  end

  # describe 'GET /auth/password/new' do
  #   before do
  #     mail = ActionMailer::Base.deliveries.last.to_s
  #     @token = /(?<=Token: )(.*)(?=<\/p>)/.match(mail)
  #     @params = {
  #       config: 'default',
  #       redirect_url: @redirect_url,
  #       reset_password_token: @token
  #     }
  #     get "/auth/password", @params
  #     raw_qs = response.location.split('?')[1]
  #     @qs = Rack::Utils.parse_nested_query(raw_qs)
  #
  #     @client_id = @qs['client_id']
  #     @expiry = @qs['expiry']
  #     @reset_password = @qs['reset_password']
  #     @token = @qs['token']
  #     @uid = @qs['uid']
  #   end
  #
  #   it 'redirects to the given url and adds url params' do
  #   end
  #
  #   it 'provides a valid token for a temporary session' do
  #     # expect { get '/auth/password/edit' }.to_not raise_error
  #   end
  # end
end
