require "rails_helper"

describe "Registrations API" do

  it "creates a new user" do
    post '/api/v1/registrations', :registration => {:name => "Roy van der Meij", :email => "roy@royapps.nl", :password => "S3cret", :password_confirmation => "S3cret"}

    expect(response).to be_success
    expect(User.first.name).to eq("Roy van der Meij")
  end

end
