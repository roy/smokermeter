require 'rails_helper'

describe Barbecue do

  context "#validations" do
    it { should belong_to :user }
    it { should have_many :thermometers }
  end

end
