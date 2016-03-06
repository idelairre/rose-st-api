require 'rails_helper'

RSpec.describe 'Auth/user routes', type: :request do
  describe 'GET #show' do
    before(:each) do
      @post = FactoryGirl.create(:post)
    end
    it 'shows the freaking post without errors' do
      expect { get "/posts/#{@post.title_url}" }.not_to raise_error
      expect(response).to have_http_status(:success)
    end
    it 'serializes response data correctly' do
      get "/posts/#{@post.title_url}"
      expect(response.headers['Content-Type']).to eq('application/json; charset=utf-8')
      expect(response.body).to include('id')
      expect(response.body).to include('title')
      expect(response.body).to include('body')
      expect(response.body).to include('subheading')
      expect(response.body).to include('user_id')
      expect(response.body).to include('user')
      expect(response.body).to include('created_at')
    end
  end
end
