class Remove < ActiveRecord::Migration[7.1]
  def change
    remove_column :answers, :title, :text

  end
end
