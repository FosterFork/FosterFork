class CreateTranslations < ActiveRecord::Migration
  def change
    create_table :translations do |t|
      t.string :title
      t.string :locale
      t.references :translatable
      t.string :translatable_type

      t.timestamps null: false
    end
    add_index :translations, :translatable_id
  end
end
