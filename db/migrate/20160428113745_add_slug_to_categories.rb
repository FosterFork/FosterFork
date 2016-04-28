class AddSlugToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :slug, :string
    add_index :categories, :slug, unique: true

    # generate slug for existing categories
    Category.find_each(&:save)
  end
end
