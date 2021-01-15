class RemoveAttrFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :user_ip, :string
  end
end
