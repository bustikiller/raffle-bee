# == Schema Information
#
# Table name: tickets
#
#  id         :integer          not null, primary key
#  raffle_id  :integer
#  user_id    :integer
#  number     :integer          not null
#  email      :string           not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_tickets_on_raffle_id  (raffle_id)
#  index_tickets_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (raffle_id => raffles.id)
#  fk_rails_...  (user_id => users.id)
#

FactoryBot.define do
  factory :ticket do
    raffle
    user
    sequence(:email) {|n| "person#{n}@example.com"}
    sequence(:name) {|n| "Customer ##{n}"}
    sequence(:number)
  end
end
