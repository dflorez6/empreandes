class AddImageLinkToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fb_image_link, :string
  end
end
