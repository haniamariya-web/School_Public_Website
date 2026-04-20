class RemoveDefaultFromAdminCode < ActiveRecord::Migration[8.1]
  def change
    change_column_default :admin_users, :admin_code, nil
  end
end