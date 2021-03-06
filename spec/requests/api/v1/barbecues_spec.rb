require "rails_helper"

describe "Barbecues API" do

  it "returns a list of barbecues" do
    create_list :barbecue, 3

    get '/api/v1/barbecues'

    expect(response).to be_success
    expect(json_response.length).to eq(3)
  end

  context "#show" do
    it "returns a single barbecue" do
      user = create(:user)
      bbq = create(:barbecue, user: user)

      get "/api/v1/barbecues/#{bbq.to_param}"

      expect(response).to be_success
      expect(json_response['name']).to eq(bbq.name)
      expect(json_response['id']).to eq(bbq.id)
      expect(json_response['user']['name']).to eq(user.name)
    end

    it 'hides sensitive user data' do
      user = create(:user)
      bbq = create(:barbecue, user: user)

      get "/api/v1/barbecues/#{bbq.to_param}"

      expect(response).to be_success
      expect(response).to_not include('password_digest')
    end

    it 'shows timestamps when admin' do
      admin = create(:admin)
      bbq = create(:barbecue, user: admin)
      sign_in admin

      get "/api/v1/barbecues/#{bbq.to_param}", {}, @env
      
      expect(response).to be_success
      expect(json_response.keys).to include('created_at')
      expect(json_response.keys).to include('updated_at')
    end
  end

  context "creating a barbecue" do
    it "creates a barbecue" do
      user = create(:user)
      sign_in user

      post '/api/v1/barbecues', {barbecue: {:name => "New bbq"}}, @env

      expect(response).to be_success
      expect(Barbecue.first.user.name).to eq(user.name)
    end

    it "returns unauthorized when nog logged in" do
      post '/api/v1/barbecues', {barbecue: {:name => "New bbq"}}, @env

      expect(response).to be_unauthorized
    end
  end

  context "editing a barbecue" do
    it "succeeds" do
      user = create(:user)
      barbecue = create(:barbecue, user: user, name: 'first')

      sign_in user
      put "/api/v1/barbecues/#{barbecue.id}", {barbecue: {name: "second"}}, @env

      barbecue.reload
      expect(response).to be_success
      expect(barbecue.name).to eq("second")
    end

    it "fails when trying to update someone elses barbecue" do
      user = create(:user)
      barbecue = create(:barbecue, user: user)
      other = create(:user)

      sign_in other
      put "/api/v1/barbecues/#{barbecue.id}", {barbecue: {name: "second"}}, @env

      barbecue.reload
      expect(response).to be_unauthorized
      expect(barbecue.name).to_not eq('second')
    end
  end

  context "deleting a barbecue" do
    it "succeeds" do
      user = create(:user)
      barbecue = create(:barbecue, user: user)

      sign_in user
      delete "/api/v1/barbecues/#{barbecue.id}", {}, @env

      expect(response).to be_succes
      expect(Barbecue.count).to eq(0)
    end

    it "fails when trying to delete someone elses barbecue" do
      user = create(:user)
      barbecue = create(:barbecue, user: user)
      other = create(:user)

      sign_in other
      delete "/api/v1/barbecues/#{barbecue.id}", {}, @env

      expect(response).to be_unauthorized
      expect(Barbecue.count).to eq(1)
    end
  end
end
