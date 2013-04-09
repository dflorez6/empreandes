class RemoveStuffFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :interest
  end
end
