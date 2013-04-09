class AddActCodeAndConfirmation < ActiveRecord::Migration
  def change
    add_column :users, :act_code, :string
    add_column :users, :activated, :boolean
  end

end
