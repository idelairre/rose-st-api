class Post < ActiveRecord::Base
  before_create :generate_identifier

  belongs_to :user
  validates :title, presence: true
  validates :title_url, presence: true
  validates :user_id, presence: true

  # gonna want validations for user and body soon
  # NOTE: rails uniqueness validations are a bit crazy

  private

  def generate_identifier
    self.identifier = SecureRandom.uuid
  end
end
