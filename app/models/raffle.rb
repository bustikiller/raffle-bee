# == Schema Information
#
# Table name: raffles
#
#  id                    :integer          not null, primary key
#  name                  :string(255)      not null
#  starts_on             :date             not null
#  ends_on               :date             not null
#  max_number_of_tickets :integer          not null
#  price                 :decimal(10, )    not null
#  user_id               :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
# Indexes
#
#  index_raffles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class Raffle < ApplicationRecord
  belongs_to :user

  validates_presence_of :name, :starts_on, :ends_on, :max_number_of_tickets, :price
  validates :max_number_of_tickets, numericality: { only_integer: true,
                                                    greater_than_or_equal_to: 100,
                                                    less_than_or_equal_to: 100_000 }

  validates :price, numericality: {greater_than: 0}
end
