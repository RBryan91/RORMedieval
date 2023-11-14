class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :name
      t.string :image
      t.string :category
      t.integer :pv
      t.integer :force
      t.integer :xp

      t.timestamps
    end
  end
end
