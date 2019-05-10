class CreateResultModel < ActiveRecord::Migration[5.2]
  def change
    create_table :results do |t|
      t.date :date, null: false, unique: true
      t.integer :number, null: false

      t.timestamps
    end
  end
end
