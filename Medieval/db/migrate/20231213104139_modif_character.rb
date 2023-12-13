class ModifCharacter < ActiveRecord::Migration[7.1]
  def change
    add_column :characters, :step_id, :integer
  end
end
