class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :owner_id
      t.string :slug
      t.string :recurrence
      t.string :title
      t.text :abstract
      t.text :description
      t.string :address
      t.string :city
      t.string :zip
      t.string :country
      t.datetime :date
      t.decimal :latitude,  precision: 15, scale: 10
      t.decimal :longitude, precision: 15, scale: 10
      t.boolean :approved,  null: false, default: false
      t.boolean :public,    null: false, default: false
      t.boolean :active,    null: false, default: false
      t.boolean :participation_wanted, null: false, default: false
      t.string :secret

      t.timestamps null: false
    end

    add_index :projects, :slug, unique: true
  end
end
