class CreateEnigmes < ActiveRecord::Migration[7.1]
  def change
    create_table :enigmes do |t|
      t.text :titre

      t.timestamps
    end
  end
end
