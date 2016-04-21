class CreateInquiries < ActiveRecord::Migration
  def change
    create_table :inquiries do |t|
      t.references :user, index: true, foreign_key: true
      t.references :project, index: true, foreign_key: true
      t.text :content

      t.timestamps null: false
    end
  end
end
