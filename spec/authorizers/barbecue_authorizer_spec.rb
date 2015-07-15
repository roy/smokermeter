require "spec_helper"
require_relative "../../app/authorizers/base_authorizer"
require_relative "../../app/authorizers/barbecue_authorizer"

describe BarbecueAuthorizer do
  context "#initialize" do
    it "accepts a barbecue and a user" do
      bbq = double(:barbecue)
      user = double(:user)

      authorizer = BarbecueAuthorizer.new(user, bbq)

      expect(authorizer.model).to eq(bbq)
      expect(authorizer.user).to eq(user)
    end
  end

  context "#update?" do
    it 'allows as an admin' do
      bbq = double(:barbecue)
      user = double(:user)
      allow(user).to receive(:admin?).and_return(true)

      authorizer = described_class.new(user, bbq)

      expect(authorizer.update?).to eq(true)
    end

    it 'allows if user owns model' do
      bbq = double(:barbecue)
      user = double(:user, admin?: false)

      allow(user).to receive(:id).and_return(1)
      allow(bbq).to receive(:user_id).and_return(1)

      authorizer = described_class.new(user, bbq)

      expect(authorizer.update?).to eq(true)
    end

    it "denies if user does not own model" do
      bbq = double(:barbecue, user_id: 2)
      user = double(:user, admin?: false, id: 1)

      authorizer = described_class.new(user, bbq)

      expect(authorizer.update?).to eq(false)
    end
  end

  context "#destroy?" do
    it 'allows as an admin' do
      user = double(:user, admin?: true)
      authorizer = described_class.new(user, double)

      expect(authorizer.destroy?).to eq(true)
    end

    it 'allows if user owns model' do
      user = double(:user, admin?: false, id: 1)
      bbq = double(:barbecue, user_id: 1)

      authorizer = described_class.new(user, bbq)

      expect(authorizer.destroy?).to eq(true)
    end

    it 'denies if user does not own model' do
      user = double(:user, admin?: false, id: 1)
      bbq = double(:barbecue, user_id: 2)

      authorizer = described_class.new(user, bbq)

      expect(authorizer.destroy?).to eq(false)
    end
  end

  context "#show?" do
    it 'allows always' do
      authorizer = described_class.new(double, double)
      expect(authorizer.show?).to eq(true)
    end
  end
end
