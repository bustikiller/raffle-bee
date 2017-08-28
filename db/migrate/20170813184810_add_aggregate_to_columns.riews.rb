# This migration comes from riews (originally 20170813184708)
class AddAggregateToColumns < ActiveRecord::Migration[5.1]
  def change
    add_column :riews_columns, :aggregate, :integer, limit: 2
  end
end
