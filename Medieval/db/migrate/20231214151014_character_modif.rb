class CharacterModif < ActiveRecord::Migration[7.1]
  def change
    add_column :characters, :bonus_xp, :integer
  end
end
