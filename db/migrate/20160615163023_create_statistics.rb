class CreateStatistics < ActiveRecord::Migration
  def change
    create_table :statistics do |t|
      t.text :data

      t.timestamps null: false
    end
  end
end
