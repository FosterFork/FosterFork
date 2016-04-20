class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.string :color
      t.integer :priority, null: false, default: 0

      t.timestamps null: false
    end
  end
end
