require "rails_helper"

RSpec.describe Raffle, type: :model do
  describe 'validation' do
    describe 'price' do
      it 'should be greater than 0' do
        expect(build :raffle, price: -1).not_to be_valid
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