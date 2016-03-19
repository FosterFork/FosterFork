class CreateAbuseReports < ActiveRecord::Migration
  def change
    create_table :abuse_reports do |t|
      t.integer :project_id
      t.integer :reporter_id
      t.integer :resolver_id
      t.text :reason

      t.timestamps null: false
    end
  end
end
