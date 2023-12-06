class AddPasswordToPlayers < ActiveRecord::Migration[7.1]
  def change
    add_column :players, :password, :string
  end
end
