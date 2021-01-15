class AddAttributeToLocation < ActiveRecord::Migration[6.0]
  def change
    add_column :locations, :user_id, :integer
  end
end
