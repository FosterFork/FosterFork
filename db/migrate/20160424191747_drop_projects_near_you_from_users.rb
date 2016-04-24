class DropProjectsNearYouFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :mail_on_nearby_project
  end
end
