require "spec_helper"
require_relative "../../app/authorizers/base_authorizer"
require_relative "../../app/authorizers/thermometer_authorizer"

describe ThermometerAuthorizer do
  context "#initialize" do
    it 'accepts user, barbecue and thermometer' do
      bbq = double(:barbecue)
      user = double(:user)
      thermometer = double(:thermometer)

      authorizer = ThermometerAuthorizer.new(user, bbq, thermometer)

      expect(authorizer.barbecue).to eq(bbq)
      expect(authorizer.user).to eq(user)
      expect(authorizer.thermometer).to eq(thermometer)
    end
  end

  context "#update?" do
    it 'allows as an admin' do
      admin = double(:user, admin?: true)
      bbq = double(:barbecue)
      thermometer = double(:thermometer)
      
      authorizer = described_class.new(admin, bbq, thermometer)

      expect(authorizer.update?).to eq(true)
    end

    it 'allows as an owner' do
      user = double(:user, admin?: false, id: 1)
      bbq = double(:barbecue, user_id: 1, id: 2)
      thermometer = double(:thermometer, barbecue_id: 2)

      authorizer = described_class.new(user, bbq, thermometer)

      expect(authorizer.update?).to eq(true)
    end

    it 'denies if user does not own barbecue' do
      user = double(:user, admin?: false, id: 1)
      bbq = double(:barbecue, user_id: 1, id: 2)
      thermometer = double(:thermometer, barbecue_id: 2)
      other = double(:other, admin?: false, id: 3)

      authorizer = described_class.new(other, bbq, thermometer)

      expect(authorizer.update?).to eq(false)
    end
  end

  context "#destroy?" do
    it 'allows as an admin' do
      admin = double(:user, admin?: true)
      bbq = double(:barbecue)
      thermometer = double(:thermometer)
      
      authorizer = described_class.new(admin, bbq, thermometer)

      expect(authorizer.destroy?).to eq(true)
    end

    it 'allows as an owner' do
      user = double(:user, admin?: false, id: 1)
      bbq = double(:barbecue, user_id: 1, id: 2)
      thermometer = double(:thermometer, barbecue_id: 2)

      authorizer = described_class.new(user, bbq, thermometer)

      expect(authorizer.destroy?).to eq(true)
    end

    it 'denies if user does not own barbecue' do
      user = double(:user, admin?: false, id: 1)
      bbq = double(:barbecue, user_id: 1, id: 2)
      thermometer = double(:thermometer, barbecue_id: 2)
      other = double(:other, admin?: false, id: 3)

      authorizer = described_class.new(other, bbq, thermometer)

      expect(authorizer.destroy?).to eq(false)
    end
  end
end
