class UserSerializer < ActiveModel::Serializer
  attributes :id, :nickname, :email, :created_at, :updated_at

  has_many :posts
end
