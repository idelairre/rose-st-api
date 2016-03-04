require 'rails_helper'
require 'spec_helper'

RSpec.describe 'User authentication routes', type: :request do
  before(:each) do
    @resource = FactoryGirl.create(:user)
    @resource.skip_confirmation!
    @resource.save!

    @resource_auth_headers = @resource.create_new_auth_token
  end
  it 'creates a user' do
    user = FactoryGirl.attributes_for(:user)
    @resource_auth_headers.each do |k, v|
      user[k] = v
    end

    puts user
    expect(User.all.count).to eq(1)
    post '/auth', user
    expect(response).to have_http_status(200)
    expect(User.all.count).to eq(2)
  end
end
