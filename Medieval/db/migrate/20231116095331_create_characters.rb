class CreateCharacters < ActiveRecord::Migration[7.1]
  def change
    create_table :characters do |t|
      t.string :name
      t.references :player, null: false, foreign_key: true
      t.string :avatar
      t.integer :xp
      t.integer :force
      t.integer :pv
      t.integer :po

      t.timestamps
    end
  end
end
