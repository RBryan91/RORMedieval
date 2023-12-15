class AddNewColumnToStepPo < ActiveRecord::Migration[7.1]
  def change
    add_column :steps, :po, :integer
    Step.update_all(po: 25)
  end
end
