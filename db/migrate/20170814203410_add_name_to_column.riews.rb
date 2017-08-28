# This migration comes from riews (originally 20170814203309)
class AddNameToColumn < ActiveRecord::Migration[5.1]
  def change
    add_column :riews_columns, :name, :string
  end
end
