# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)      not null
#  password_digest :string(255)      not null
#  session_token   :string(255)      not null
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
  attr_reader :password

  validates :username, :session_token, presence: true
  validates :password_digest, presence: { message: "password can't be blank"}
  validates :password, length: { minimum: 6, allow_nil: true }
  before_validation :ensure_session_token

  has_many :moderated_subs, class_name: 'Sub', foreign_key: :moderator_id
  has_many :submitted_links, class_name: 'Link', foreign_key: :submitter_id
  has_many :authored_comments, class_name: 'Comment', foreign_key: :author_id
  has_many :user_votes

  def self.find_by_credentials(creds)
    user = User.find_by_username(creds[:username])
    user.try(:is_password?, creds[:password]) ? user : nil
  end

  def password=(plain_text)
    @password = plain_text
    self.password_digest = BCrypt::Password.create(plain_text)
  end

  def is_password?(plain_text)
    BCrypt::Password.new(password_digest).is_password?(plain_text)
  end

  def reset_session_token!
    self.session_token = SecureRandom.hex
    self.save!
    session_token
  end

  def ensure_session_token
    self.session_token ||= SecureRandom.hex
  end
end
