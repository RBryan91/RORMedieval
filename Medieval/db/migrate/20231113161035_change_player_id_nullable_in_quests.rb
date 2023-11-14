class ChangePlayerIdNullableInQuests < ActiveRecord::Migration[7.1]
  def change
    change_column :quests, :player_id, :bigint, null: true
  end
end
