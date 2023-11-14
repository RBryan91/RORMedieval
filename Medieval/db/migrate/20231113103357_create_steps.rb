class CreateSteps < ActiveRecord::Migration[7.1]
  def change
    create_table :steps do |t|
      t.references :quest, null: false, foreign_key: true
      t.references :monster, null: false, foreign_key: true
      t.references :enigme, null: false, foreign_key: true
      t.integer :xp
      t.string :titre
      t.references :player, null: false, foreign_key: true

      t.timestamps
    end
  end
end
