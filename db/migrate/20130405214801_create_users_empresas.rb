class CreateUsersEmpresas < ActiveRecord::Migration
  def up
    create_table :users_empresas, :id => false do |t|
      t.integer :user_id
      t.integer :empresa_id
    end
  end

  def down
    drop_table :users_empresas
  end
end
