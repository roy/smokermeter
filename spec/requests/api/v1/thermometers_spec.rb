require "rails_helper"

describe "Thermometers API" do
  
  context "#index" do
    it "returns a list of thermometers for a barbecue" do
      bbq = create(:barbecue_with_thermometers, thermometers_count: 3)

      get "/api/v1/barbecues/#{bbq.id}/thermometers"

      expect(response).to be_success
      expect(json_response.length).to eq(3)
    end
  end

  context "#show" do
    it "returns a single thermometer" do
      bbq = create(:barbecue)
      thermometer = create(:thermometer, barbecue: bbq)

      get "/api/v1/barbecues/#{bbq.id}/thermometers/#{thermometer.id}"

      expect(response).to be_success
    end
  end

  context "#create" do
    it "creates when user is logged in" do
      user = create(:user)
      bbq = create(:barbecue, user: user)
      thermometer_arguments = {location: "grill"}

      sign_in user
      post "/api/v1/barbecues/#{bbq.id}/thermometers", {thermometer: thermometer_arguments}, @env

      expect(response).to be_success
      expect(bbq.thermometers.first.location).to eq('grill')
    end

    it "fails when user is not logged in" do
      bbq = create(:barbecue)
      thermometer_arguments = {location: 'grill'}

      post "/api/v1/barbecues/#{bbq.id}/thermometers", thermometer: thermometer_arguments

      expect(response).to be_unauthorized
      expect(bbq.thermometers.count).to eq(0)
    end
  end

  context "#update" do
    it "allows update for admin" do
      user = create(:user)
      admin = create(:admin)
      bbq = create(:barbecue, user: user)
      thermometer = create(:thermometer, barbecue: bbq, location: 'grill')
      arguments = {location: 'hood'}

      sign_in admin 
      put "/api/v1/barbecues/#{bbq.id}/thermometers/#{thermometer.id}", {thermometer: arguments}, @env

      expect(response).to be_success
      expect(bbq.thermometers.first.location).to eq('hood')
    end

    it "allows update for owner" do
      user = create(:user)
      bbq = create(:barbecue, user: user)
      thermometer = create(:thermometer, barbecue: bbq, location: 'grill')
      arguments = {location: 'hood'}

      sign_in user
      put "/api/v1/barbecues/#{bbq.id}/thermometers/#{thermometer.id}", {thermometer: arguments}, @env

      expect(response).to be_success
      expect(bbq.thermometers.first.location).to eq('hood')
    end

    it "denies update for other" do
      user = create(:user)
      bbq = create(:barbecue, user: user)
      thermometer = create(:thermometer, barbecue: bbq, location: 'grill')
      other = create(:user)
      arguments = {location: 'hood'}

      sign_in other
      put "/api/v1/barbecues/#{bbq.id}/thermometers/#{thermometer.id}", {thermometer: arguments}, @env

      expect(response).to be_unauthorized
    end
  end

  context "#destroy" do
    it 'allows for admin' do
      user = create(:user)
      bbq = create(:barbecue, user: user)
      thermometer = create(:thermometer, barbecue: bbq)
      admin = create(:admin)

      sign_in admin
      delete "/api/v1/barbecues/#{bbq.id}/thermometers/#{thermometer.id}", {}, @env

      expect(response).to be_success
      expect(bbq.thermometers.count).to eq(0)
    end
  end
end
