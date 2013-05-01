class AddHasTeamToUsers < ActiveRecord::Migration
  def change
    add_column :users, :has_team, :boolean
  end
end
