class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :title_url, :body, :subheading, :user_id, :created_at, :updated_at

  belongs_to :user
end
