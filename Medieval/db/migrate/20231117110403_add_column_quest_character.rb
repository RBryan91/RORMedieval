class AddColumnQuestCharacter < ActiveRecord::Migration[7.1]
  def change
    add_reference :characters, :quest, foreign_key: true
  end
end
