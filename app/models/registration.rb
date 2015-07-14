class Registration
  include ActiveModel::Model
  include ActiveModel::SecurePassword

  has_secure_password

  attr_accessor :name, :email, :password_digest

  validates :name, :email, presence: true

  def save
    return false unless valid?

    persist!
    true
  end

  private
  def persist!
    @user = User.create!(name: name, email: email, password_digest: password_digest)
  end
end
