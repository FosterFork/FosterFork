class CreateLayoutImages < ActiveRecord::Migration
  def change
    create_table :layout_images do |t|
      t.string :page
      t.string :alt
      t.string :locale
      t.attachment :image

      t.timestamps null: false
    end
  end
end
