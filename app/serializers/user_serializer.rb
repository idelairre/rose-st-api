class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :nickname, :email, :admin, :confirmed, :sign_in_count, :last_sign_in_at, :created_at, :updated_at

  has_many :posts

  def email
    object.uid
  end

  def confirmed
    if !object.confirmed_at.nil?
      true
    else
      false
    end
  end
end

# User: {
#   {
#     id: integer,
#     provider: string,
#     uid: string,
#     encrypted_password: string,
#     reset_password_token: string,
#     reset_password_sent_at: datetime,
#     remember_created_at: datetime,
#     sign_in_count: integer,
#     current_sign_in_at: datetime,
#     last_sign_in_at: datetime,
#     current_sign_in_ip: string,
#     last_sign_in_ip: string,
#     confirmation_token: string,
#     confirmed_at: datetime,
#     confirmation_sent_at: datetime,
#     unconfirmed_email: string,
#     name: string,
#     nickname: string,
#     image: string,
#     email: string,
#     tokens: json,
#     created_at: datetime,
#     updated_at: datetime,
#     admin: boolean
#   }
# }
