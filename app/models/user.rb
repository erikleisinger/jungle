class User < ActiveRecord::Base
  validates :email, uniqueness: { case_sensitive: false, message: "already taken" }, presence: true
  validates :name, presence: true
  validates :password, length: { minimum: 7 }
  validates :password_confirmation, presence: true
  has_secure_password

  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email.strip.downcase)
    if user && user.authenticate(password)
      user
    else
      nil
    end
  end

  def get_email 
    self.email
  end

end
