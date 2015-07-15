require 'rails_helper'

describe Thermometer do

  context "#validations" do
    it { should validate_presence_of :location }
    it { should belong_to :barbecue }
  end

end
