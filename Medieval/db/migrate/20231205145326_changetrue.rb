class Changetrue < ActiveRecord::Migration[7.1]
  def change
    change_column :answers, :true, :text

  end
end
