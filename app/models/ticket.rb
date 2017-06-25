# == Schema Information
#
# Table name: tickets
#
#  id         :integer          not null, primary key
#  raffle_id  :integer
#  user_id    :integer
#  number     :integer          not null
#  email      :string(255)      not null
#  name       :string(255)      not null
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

class Ticket < ApplicationRecord
  belongs_to :user
  belongs_to :raffle

  attr_accessor :amount

  validates_uniqueness_of :number, scope: :raffle_id
  validates_presence_of :name, :email
  validates_format_of :email, with: Devise::email_regexp

  scope :between, -> (from, to){ where('number BETWEEN ? AND ?', from, to) }
end
