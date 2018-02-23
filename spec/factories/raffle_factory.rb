FactoryBot.define do
  factory :raffle do
    user
    name 'Raffle name'
    starts_on Date.new(2018, 1, 1)
    ends_on Date.new(2019, 1, 1)
    max_number_of_tickets 100
    price 1
  end
end