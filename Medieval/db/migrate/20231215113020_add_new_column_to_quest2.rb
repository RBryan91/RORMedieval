class AddNewColumnToQuest2 < ActiveRecord::Migration[7.1]
  def change
    Quest.update_all(po: 100)
  end
end
