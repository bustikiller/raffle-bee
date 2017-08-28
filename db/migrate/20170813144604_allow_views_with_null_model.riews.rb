# This migration comes from riews (originally 20170813144520)
class AllowViewsWithNullModel < ActiveRecord::Migration[5.1]
  def change
    change_column :riews_views, :model, :string, null: true
  end
end
