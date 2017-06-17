class CreateProjectsTags < ActiveRecord::Migration
  def change
    create_table :projects_tags do |t|
      t.references :tag, index: true, foreign_key: true
      t.references :project, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
