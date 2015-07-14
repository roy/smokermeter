FactoryGirl.define do
  sequence :name do |n|
    "name #{n}"
  end

  sequence :email do |n|
    "email-#{n}@example.com"
  end

  factory :barbecue do
    name
  end

  factory :user do
    name
    email
  end
end
