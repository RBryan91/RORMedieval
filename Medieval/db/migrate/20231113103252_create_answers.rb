class CreateAnswers < ActiveRecord::Migration[7.1]
  def change
    create_table :answers do |t|
      t.references :enigme, null: false, foreign_key: true
      t.boolean :true
      t.text :title

      t.timestamps
    end
  end
end
