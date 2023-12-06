class AddTrueNulll < ActiveRecord::Migration[7.1]
  def change
    change_column :steps, :player_id, :bigint, null: true
    change_column :steps, :monster_id, :bigint ,null: true
    change_column :steps, :enigme_id, :bigint ,null: true
  end
end
