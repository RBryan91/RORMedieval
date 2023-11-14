class CreateHdvs < ActiveRecord::Migration[7.1]
  def change
    create_table :hdvs do |t|
      t.references :item, null: false, foreign_key: true
      t.references :player, null: false, foreign_key: true
      t.integer :price

      t.timestamps
    end
  end
end
