FactoryGirl.define do
  sequence :name do |n|
    "name #{n}"
  end

  factory :barbecue do
    name
  end
end
