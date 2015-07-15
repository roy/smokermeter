class Barbecue < ActiveRecord::Base
  belongs_to :user

  has_many :thermometers, dependent: :destroy
end
