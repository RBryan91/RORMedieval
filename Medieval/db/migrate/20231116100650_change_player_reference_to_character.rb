class ChangePlayerReferenceToCharacter < ActiveRecord::Migration[7.1]
  def change
    remove_reference :inventories, :player, foreign_key: true
    add_reference :inventories, :character, null: false, foreign_key: true
    remove_reference :hdvs, :player, foreign_key: true
    add_reference :hdvs, :character, null: false, foreign_key: true
    remove_reference :quests, :player, foreign_key: true
    add_reference :quests, :character, null: true, foreign_key: true
    remove_reference :steps, :player, foreign_key: true
    add_reference :steps, :character, null: true, foreign_key: true
  end
end
