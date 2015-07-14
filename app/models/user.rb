class User < ActiveRecord::Base
  include ActiveModel::SecurePassword

  has_secure_password

  validates :name, :email, presence: true

  has_many :barbecues

  def admin?
    is_admin == true
  end
end
