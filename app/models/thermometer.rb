class Thermometer < ActiveRecord::Base
  belongs_to :barbecue

  validates :location, presence: true
end
