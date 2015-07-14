require 'rails_helper'

describe Barbecue do
  context "#validations" do
    it { should belong_to :user }
  end
end
