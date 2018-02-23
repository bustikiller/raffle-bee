require "rails_helper"

RSpec.describe Raffle, type: :model do
  describe 'validation' do
    describe 'price' do
      it 'should be greater than 0' do
        expect(build :raffle, price: -1).not_to be_valid
      end
    end
  end
end