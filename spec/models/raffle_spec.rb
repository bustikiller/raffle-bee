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

require "rails_helper"

RSpec.describe Raffle, type: :model do
  describe 'validation' do
    describe 'price' do
      it 'should be greater than 0' do
        expect(build :raffle, price: -1).not_to be_valid
      end
    end

    describe 'sellers' do
      it 'cannot be duplicated' do
        raffle = create :raffle
        user = create :user
        raffle.sellers << user
        expect { raffle.sellers << user }.to raise_error(ActiveRecord::RecordNotUnique)
      end
    end
  end

  describe '#public_date' do
    it 'returns a day after the raffle has ended' do
      raffle = create :raffle, ends_on: Date.new(2018, 1, 1)
      expect(raffle.public_date).to eq(Date.new(2018, 1, 2))
    end
  end

  describe '#amount_gathered' do
    it 'calculates the incomes of the raffle' do
      raffle = build :raffle, price: 4
      3.times { create :ticket, raffle: raffle }
      expect(raffle.amount_gathered).to eq 12
    end
  end
end
