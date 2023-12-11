class RemoveColumnsFromPlayers < ActiveRecord::Migration[7.1]
  def change
    remove_column :players, :xp, :integer
    remove_column :players, :pv, :integer
    remove_column :players, :force, :integer
    remove_column :players, :po, :integer
    remove_column :players, :avatar, :string
  end
end
