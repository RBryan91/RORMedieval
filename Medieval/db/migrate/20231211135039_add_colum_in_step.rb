class AddColumInStep < ActiveRecord::Migration[7.1]
  def change
    add_column :quests, :level, :integer
  end
end
