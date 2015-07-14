require "rails_helper"

describe Registration do

  context "#validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :email  }
    it { should validate_presence_of :password }
  end

  context "#save" do
    it 'creates a user' do
      registration = build_registration

      registration.save

      expect(User.first.name).to eq("Roy")
    end
  end

  def build_registration
    params = {
      name: "Roy", 
      email: "roy@royapps.nl", 
      password: "S3cret",
      password_confirmation: "S3cret"
    }

    registration = Registration.new(params)
  end

end
