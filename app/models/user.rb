class User < ActiveRecord::Base
  has_many :posts

  has_secure_password
  enum role: [:admin]

  before_create :set_token

  validates :password, length: { minimum: 6 }

  before_create :generate_token
  before_save { self.email = email.downcase }

  private

  def set_token
    return if token.present?
    self.token = generate_token
  end

  def generate_token
    SecureRandom.uuid.gsub(/\-/,'')
  end
end
