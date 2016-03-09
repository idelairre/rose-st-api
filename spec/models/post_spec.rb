require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'creates a post without errors' do
    expect { FactoryGirl.build(:post) }.to_not raise_error
  end

  it 'generates a uuid before it is created' do
    @post = Post.new(FactoryGirl.attributes_for(:post))
    expect{ @post.save }.to change{ @post.identifier }
  end
end
