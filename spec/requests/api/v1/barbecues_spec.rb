require "rails_helper"

describe "Barbecues API" do

  it "returns a list of barbecues" do
    create_list :barbecue, 3

    get '/api/v1/barbecues'

    expect(response).to be_success
    expect(json_response.length).to eq(3)
  end

end
