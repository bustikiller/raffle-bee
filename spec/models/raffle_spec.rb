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

  describe '#sales_summary' do
    before do

      #           [raffle_1]  [raffle_2]
      # [user 1]      1           x
      # [user 2]      3           4
      # [user 3]      x           6

      @raffle_1 = create :raffle
      @raffle_2 = create :raffle

      @user_1 = create :user
      @user_2 = create :user
      @user_3 = create :user

      @raffle_1.sellers = [@user_1, @user_2]
      @raffle_2.sellers = [@user_2, @user_3]

      create_list :ticket, 1, raffle_id: @raffle_1.id, user_id: @user_1.id
      create_list :ticket, 3, raffle_id: @raffle_1.id, user_id: @user_2.id
      create_list :ticket, 4, raffle_id: @raffle_2.id, user_id: @user_2.id
      create_list :ticket, 6, raffle_id: @raffle_2.id, user_id: @user_3.id
    end
    it 'displays the sales by person test 1' do
      expect(@raffle_1.sales_summary).to eq(@user_2.email => 3, @user_1.email => 1)
    end
    it 'displays the sales by person test 2' do
      expect(@raffle_2.sales_summary).to eq(@user_3.email => 6, @user_2.email => 4)
    end
  end
end