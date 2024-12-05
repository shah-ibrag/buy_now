class RenameAdminsToAdministrators < ActiveRecord::Migration[7.2]
  def change
    rename_table :admins, :administrators
  end
end