FactoryBot.define do
  factory :ticket do
    raffle
    user
    sequence(:email) {|n| "person#{n}@example.com"}
    sequence(:name) {|n| "Customer ##{n}"}
    sequence(:number)
  end
end