# This migration comes from riews (originally 20170813102612)
class CreateRelationshipTable < ActiveRecord::Migration[5.1]
  def change
    create_table :riews_relationships do |t|
      t.string :name
      t.references :riews_view, foreign_key: true

      t.timestamps
    end
  end
end
