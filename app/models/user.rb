# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  validates :username, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :password, length: { minimum: 2 }, allow_nil: true

  after_initialize :ensure_session_token

  has_many :moderated_subs,
    foreign_key: :moderator_id,
    class_name: 'Sub'

  has_many :posts,
    foreign_key: :author_id,
    class_name: 'Post'

  attr_reader :password

  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)
    if user
      user.is_password?(password) ? user : nil
    else
      nil
    end
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64(16)
  end

  def reset_session_token
    self.session_token = SecureRandom.urlsafe_base64(16)
    save!
    session_token
  end

  def is_password?(password)
    check_password = BCrypt::Password.new(password_digest)
    check_password.is_password?(password)
  end

end
