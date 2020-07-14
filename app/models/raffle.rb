# == Schema Information
#
# Table name: raffles
#
#  id                    :bigint(8)        not null, primary key
#  name                  :string           not null
#  starts_on             :date             not null
#  ends_on               :date             not null
#  max_number_of_tickets :integer          not null
#  price                 :decimal(5, 2)    not null
#  user_id               :bigint(8)
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

class Raffle < ApplicationRecord
  belongs_to :owner, class_name: :User, foreign_key: :user_id
  has_many :tickets, dependent: :destroy

  has_many :assignments, dependent: :destroy
  has_many :sellers, :through => :assignments, source: :user, dependent: :destroy

  validates_presence_of :name, :starts_on, :ends_on, :max_number_of_tickets, :price, :award
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

  def public_date
    ends_on + 1.day
  end

  def amount_gathered
    price * tickets.count
  end

  def sales_summary
    sellers.joins("LEFT JOIN (SELECT * from tickets where tickets.raffle_id = #{id}) AS tickets ON users.id = tickets.user_id")
        .group('users.email')
        .count('tickets.id')
        .sort_by{|_k,v| v}
        .reverse
        .to_h
  end

  private

  def define_start_and_end_dates
    self.starts_on = starts_on.beginning_of_day if starts_on
    self.ends_on = ends_on.end_of_day if ends_on
  end

  def ends_on_after_starts_on
    if starts_on && ends_on && starts_on > ends_on
      errors.add :ends_on, I18n.t('activerecord.errors.ends_on_greater_than_starts_on')
    end
  end
end
