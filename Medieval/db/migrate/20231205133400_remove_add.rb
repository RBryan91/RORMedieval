class RemoveAdd < ActiveRecord::Migration[7.1]
  def change
    remove_column :answers, :titre, :text
    add_column :answers, :reponse_1, :text
    add_column :answers, :reponse_2, :text
    add_column :answers, :reponse_3, :text

  end
end
