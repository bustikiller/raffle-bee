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

    describe 'assignments' do
      let(:assignment){ build :assignment, user: user, raffle: raffle }
      context 'when the user is a regular user' do
        it 'cannot manage the assignment' do
          expect(Ability.new(user).can?(:manage, assignment)).to be_falsey
        end
      end
      context 'when the user is a seller' do
        it 'cannot manage the assignment' do
          raffle.sellers << user
          expect(Ability.new(user).can?(:manage, assignment)).to be_falsey
        end
      end
      context 'when the user is the owner' do
        it 'can manage the assignments' do
          raffle.update owner: user
          expect(Ability.new(user).can?(:manage, assignment)).to be_truthy
        end
      end
    end
  end
end