# This migration comes from riews (originally 20170813170515)
class AddUniquenessFieldToView < ActiveRecord::Migration[5.1]
  def change
    add_column :riews_views, :uniqueness, :boolean, default: false, null: false
  end
end
