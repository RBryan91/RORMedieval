class CreateQuests < ActiveRecord::Migration[7.1]
  def change
    create_table :quests do |t|
      t.string :title
      t.integer :xp
      t.references :item, null: false, foreign_key: true
      t.references :player, null: false, foreign_key: true
      t.references :master, null: false, foreign_key: true

      t.timestamps
    end
  end
end
