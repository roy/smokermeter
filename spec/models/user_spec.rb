require "rails_helper"

describe User do

  context "#validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :email }
  end

end
