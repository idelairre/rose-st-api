class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :title_url, :body, :subheading, :user_id, :user, :created_at, :updated_at

  belongs_to :user

  def user
    object.user.email
  end
end
