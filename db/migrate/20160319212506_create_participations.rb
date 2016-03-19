class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.integer :user_id
      t.integer :project_id
      t.string :secret

      t.timestamps null: false
    end

    add_index :participations, :user_id
    add_index :participations, :project_id
    add_index :participations, [ :user_id, :project_id ], unique: true
    add_index :participations, :secret
  end
end
