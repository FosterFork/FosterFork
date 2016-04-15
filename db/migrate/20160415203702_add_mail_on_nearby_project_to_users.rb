class AddMailOnNearbyProjectToUsers < ActiveRecord::Migration
  def change
    add_column :users, :mail_on_nearby_project, :boolean, null: false, default: false
  end
end
