require "rails_helper"

describe "Barbecues API" do

  it "returns a list of barbecues" do
    create_list :barbecue, 3

    get '/api/v1/barbecues'

    expect(response).to be_success
    expect(json_response.length).to eq(3)
  end

  it "returns a single barbecue" do
    user = create(:user)
    bbq = create(:barbecue, user: user)

    get "/api/v1/barbecues/#{bbq.to_param}"

    expect(response).to be_success
    expect(json_response['name']).to eq(bbq.name)
    expect(json_response['id']).to eq(bbq.id)
    expect(json_response['user']['name']).to eq(user.name)
  end

  context "creating a barbecue" do
    it "creates a barbecue" do
      user = create(:user)
      sign_in user

      post '/api/v1/barbecues', {barbecue: {:name => "New bbq"}}, @env

      expect(response).to be_success
      expect(Barbecue.first.user.name).to eq(user.name)
    end
  end
end
