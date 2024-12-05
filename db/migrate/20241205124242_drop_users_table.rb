class DropUsersTable < ActiveRecord::Migration[7.2]
  def up
    drop_table :users
  end

  def down
    create_table :users do |t|
      t.string :username
      t.string :password_digest

      t.timestamps
    end
  end
end