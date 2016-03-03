class Post < ActiveRecord::Base
  belongs_to :user
  validates :title, presence: true
  validates :title_url, presence: true
  # gonna want validations for user and body soon
  # NOTE: rails uniqueness validations are a bit crazy
end
