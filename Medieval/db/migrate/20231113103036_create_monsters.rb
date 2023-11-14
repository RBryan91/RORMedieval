class CreateMonsters < ActiveRecord::Migration[7.1]
  def change
    create_table :monsters do |t|
      t.integer :force
      t.integer :pv
      t.string :avatar
      t.references :item, null: false, foreign_key: true
      t.integer :rate
      t.string :name
      t.boolean :active
      t.text :message

      t.timestamps
    end
  end
end
