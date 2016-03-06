require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  before do
    FactoryGirl.create(:post)
  end
  describe 'GET #index' do
    it 'lists all posts' do
      expect { get :index }.not_to raise_error
      expect(response).to have_http_status(200)
    end
  end
  describe 'POST #create with authentcated user' do
    before(:each) do
      user = double('user')
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return(user)
    end

    it 'should have a current_user' do
      # note the fact that you should remove the "validate_session" parameter if this was a scaffold-generated controller
      expect(subject.current_user).to_not eq(nil)
    end

    it 'creates a post' do
      post :create, { post: FactoryGirl.attributes_for(:post) }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create with unauthentcated user' do
    before(:each) do
      allow(request.env['warden'])
        .to receive(:authenticate!)
        .and_throw(:warden, { :scope => :user })
    end

    it 'should not have a current_user' do
      # note the fact that you should remove the "validate_session" parameter if this was a scaffold-generated controller
      expect(subject.current_user).to eq(nil)
    end

    it 'creates a post' do
      post :create, { post: FactoryGirl.attributes_for(:post) }
      expect(response).to have_http_status(401)
    end
  end
end
