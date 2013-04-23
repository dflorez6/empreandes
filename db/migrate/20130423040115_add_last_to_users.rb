class AddLastToUsers < ActiveRecord::Migration
  def change
    add_column :users, :apellido, :string
    add_column :users, :pagweb, :string
    add_column :users, :sector, :string

  end
end
