class AddNewColumnToCharacters < ActiveRecord::Migration[7.1]
  def change
    Character.update_all(bonus_xp: 0)
  end
end
