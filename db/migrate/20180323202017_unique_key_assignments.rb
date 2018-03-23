class UniqueKeyAssignments < ActiveRecord::Migration[5.1]
  def change
    add_index :assignments, [:raffle_id, :user_id], unique: true
  end
end
