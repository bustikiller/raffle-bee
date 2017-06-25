class AddDecimalToRafflePrice < ActiveRecord::Migration[5.1]
  def up
    change_column :raffles, :price, :decimal, null: false, precision: 5, scale: 2
  end

  def down
    change_column :raffles, :price, :decimal, null: false
  end
end
