class CreateLevels < ActiveRecord::Migration[7.1]
  def change
    create_table :levels do |t|
      t.integer :level
      t.integer :xp_total

      t.timestamps
    end
  end
end
