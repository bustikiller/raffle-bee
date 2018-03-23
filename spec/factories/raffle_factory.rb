# == Schema Information
#
# Table name: raffles
#
#  id                    :integer          not null, primary key
#  name                  :string           not null
#  starts_on             :date             not null
#  ends_on               :date             not null
#  max_number_of_tickets :integer          not null
#  price                 :decimal(5, 2)    not null
#  user_id               :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  award                 :text
#
# Indexes
#
#  index_raffles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

FactoryBot.define do
  factory :raffle do
    association :owner, factory: :user
    name 'Raffle name'
    starts_on Date.new(2018, 1, 1)
    ends_on Date.new(2019, 1, 1)
    max_number_of_tickets 100
    price 1
    award 'Test award'
  end
end
