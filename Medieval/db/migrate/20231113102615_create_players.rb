class CreatePlayers < ActiveRecord::Migration[7.1]
  def change
    create_table :players do |t|
      t.integer :xp
      t.integer :pv
      t.integer :force
      t.string :name
      t.string :avatar
      t.integer :po

      t.timestamps
    end
  end
end
