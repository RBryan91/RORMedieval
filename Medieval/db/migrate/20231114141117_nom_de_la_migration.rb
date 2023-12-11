class NomDeLaMigration < ActiveRecord::Migration[7.1]
  def change
    change_column :monsters, :item_id, :bigint, null: true
  end
end
