class AddNewColumnToQuest < ActiveRecord::Migration[7.1]
  def change
    add_column :quests, :po, :integer
  end
end
