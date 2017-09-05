# This migration comes from riews (originally 20170903000001)
class RemoveForeignKeyOnArguments < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :riews_arguments, column: :argumentable_id
  end
end
