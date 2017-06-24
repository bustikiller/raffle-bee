class CreateRaffles < ActiveRecord::Migration[5.1]
  def change
    create_table :raffles do |t|
      t.string :name, null: false
      t.date :starts_on, null: false
      t.date :ends_on, null: false
      t.integer :max_number_of_tickets, null: false
      t.decimal :price, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
