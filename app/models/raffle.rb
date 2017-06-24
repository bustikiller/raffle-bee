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

  validates_presence_of :name, :starts_on, :edns_on, :max_number_of_tickets, :price
end
