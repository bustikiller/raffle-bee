class AddFieldsToRaffle < ActiveRecord::Migration[5.1]
  def change
    add_column :raffles, :award, :text
  end
end
