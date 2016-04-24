class AddProjectProximityToUsers < ActiveRecord::Migration
  def change
    add_column :users, :project_proximity, :decimal
    User.where(mail_on_nearby_project: true).update_all(project_proximity: 10)
  end
end
