require "rails_helper"

RSpec.describe Ability, type: :model do
  describe 'regular user' do
    let(:user) { create :user, role_id: Role::ROLES[:regular_user] }
    let(:raffle) { create :raffle }
    describe 'raffles' do
      [:read, :new_sale, :create_sale].each do |action|
        it "cannot #{action} unassigned raffles" do
          expect(Ability.new(user).can?(action, raffle)).to be_falsey
        end
        it "can #{action} assigned raffles" do
          raffle.sellers << user
          expect(Ability.new(user).can?(action, raffle)).to be_truthy
        end
      end
    end
  end
end