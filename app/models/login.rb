class Login
  include ActiveModel::Model

  attr_accessor :email, :password

  validates :email, presence: true
  validates :password, presence: true

  def authenticate
    if valid?
      user = User.find_by(email: email).try(:authenticate, password)
      return user if user
      errors.add(:base, 'Invalid username and/or password.')
      return nil
    end
  end

  def persisted?
    false
  end
end