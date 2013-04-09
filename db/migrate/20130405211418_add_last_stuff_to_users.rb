class AddLastStuffToUsers < ActiveRecord::Migration
  def change
    add_column :users, :codigo, :integer
    add_index  :users, :codigo, :unique => true
    add_column :users, :programa, :string
    add_column :users, :estado, :string
  end
end
