class CreateTranslations < ActiveRecord::Migration
  def change
    create_table :translations do |t|
      t.string :title
      t.string :locale
      t.references :translatable, index: true, foreign_key: true
      t.string :translatable_type

      t.timestamps null: false
    end
  end
end
