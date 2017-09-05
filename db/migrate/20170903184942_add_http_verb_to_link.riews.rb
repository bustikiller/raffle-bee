# This migration comes from riews (originally 20170903000002)
class AddHttpVerbToLink < ActiveRecord::Migration[5.1]
  def change
    add_column :riews_action_links, :http_verb, :integer, limit: 1, null: false, default: 0
  end
end
