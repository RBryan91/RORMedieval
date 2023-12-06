class RenamePasswordToPasswordDigestInMasters < ActiveRecord::Migration[7.1]
  def change
    rename_column :masters, :password, :password_digest
  end
end
