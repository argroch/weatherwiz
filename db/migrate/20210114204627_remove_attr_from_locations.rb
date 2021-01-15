class RemoveAttrFromLocations < ActiveRecord::Migration[6.0]
  def change
    remove_column :locations, :user_ip, :string
  end
end
