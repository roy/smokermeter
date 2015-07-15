FactoryGirl.define do
  sequence :name do |n|
    "name #{n}"
  end

  sequence :email do |n|
    "email-#{n}@example.com"
  end

  sequence :location do |n|
    "location #{n}"
  end

  factory :user do
    name
    email
    password 'password'
  end

  factory :barbecue do
    name

    factory :barbecue_with_thermometers do
      transient do
        thermometers_count 3
      end

      after(:create) do |barbecue, evaluator|
        create_list(:thermometer, evaluator.thermometers_count, barbecue: barbecue)
      end
    end
  end

  factory :thermometer do
    location
  end

end
