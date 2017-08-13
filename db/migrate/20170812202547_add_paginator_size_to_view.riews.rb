# This migration comes from riews (originally 20170812202251)
class AddPaginatorSizeToView < ActiveRecord::Migration[5.1]
  def change
    add_column :riews_views, :paginator_size, :integer, default: 0, null: false
  end
end
