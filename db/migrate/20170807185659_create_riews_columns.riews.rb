# This migration comes from riews (originally 20170807184652)
class CreateRiewsColumns < ActiveRecord::Migration[5.1]
  def change
    create_table :riews_columns do |t|
      t.string :method
      t.references :riews_view, foreign_key: true

      t.timestamps
    end
  end
end
