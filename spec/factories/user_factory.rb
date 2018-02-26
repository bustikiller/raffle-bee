FactoryBot.define do
  factory :user do
    sequence(:email) {|n| "test#{n}@test.com"}
    password 'test_password'
  end
end