class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :password
      t.string :email
      t.string :bio
      t.string :interest
      t.boolean :admin
      t.string :oauth_token
      t.datetime :oath_expires_at
      t.string :uid
      t.boolean :fb_connected

      t.timestamps
    end
  end
end
