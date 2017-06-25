class CreateTickets < ActiveRecord::Migration[5.1]
  def change
    create_table :tickets do |t|
      t.references :raffle, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :number, null: false
      t.string :email, null: false
      t.string :name, null: false

      t.timestamps
    end
  end
end
