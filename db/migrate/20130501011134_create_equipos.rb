class CreateEquipos < ActiveRecord::Migration
  def change
    create_table :equipos do |t|
      t.string :name
      t.integer :nit
      t.integer :max
      t.string :user1
      t.string :mail_user1
      t.string :user2
      t.string :mail_user2
      t.string :user3
      t.string :mail_user3
      t.integer :user_id
      t.timestamps
    end
  end
end
