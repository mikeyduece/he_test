FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password }
    first_name { Faker::Name.first_name }
    first_name { Faker::Name.last_name }
  end
end
