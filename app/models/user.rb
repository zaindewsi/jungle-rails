class User < ActiveRecord::Base
  validates :name, presence: true
  validates :email, presence: true
  validates_uniqueness_of :email, case_sensitive: false
  validates :password, presence: true, length: { minimum: 3 }
  validates :password_confirmation, presence: true

  has_secure_password

  def self.authenticate_with_credentials(email, password)
    email = email.downcase.strip

    user = User.find_by(email: email)

    user && user.authenticate(password) ? user : nil
  end
end
