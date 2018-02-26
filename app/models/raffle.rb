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
#  prize                 :text
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
  belongs_to :owner, class_name: :User, foreign_key: :user_id
  has_many :tickets

  has_many :assignments
  has_many :sellers, :through => :assignments, source: :user

  validates_presence_of :name, :starts_on, :ends_on, :max_number_of_tickets, :price
  validates :max_number_of_tickets, numericality: { only_integer: true,
                                                    greater_than_or_equal_to: 100,
                                                    less_than_or_equal_to: 100_000 }

  validates :price, numericality: {greater_than: 0}

  validate :ends_on_after_starts_on

  before_validation :define_start_and_end_dates

  def sell_several_tickets(ticket_template, amount)
    occupied_numbers = tickets.pluck :number
    available_numbers = numbers_range.to_a - occupied_numbers
    chosen_numbers = available_numbers.sample(amount)
    Ticket.transaction do
      chosen_numbers.each do |number|
        new_ticket = ticket_template.dup
        new_ticket.number = number
        new_ticket.save!
      end
    end
    chosen_numbers
  end

  def numbers_range
    (0...max_number_of_tickets)
  end

  private

  def define_start_and_end_dates
    starts_on = starts_on.beginning_of_day if starts_on
    ends_on = ends_on.end_of_day if ends_on
  end

  def ends_on_after_starts_on
    if starts_on && ends_on && starts_on > ends_on
      errors.add :ends_on, I18n.t('activerecord.errors.ends_on_greater_than_starts_on')
    end
  end
end
