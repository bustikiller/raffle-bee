# == Schema Information
#
# Table name: assignments
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  raffle_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_assignments_on_raffle_id              (raffle_id)
#  index_assignments_on_raffle_id_and_user_id  (raffle_id,user_id) UNIQUE
#  index_assignments_on_user_id                (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (raffle_id => raffles.id)
#  fk_rails_...  (user_id => users.id)
#

FactoryBot.define do
  factory :assignment do
    raffle
    user
  end
end
