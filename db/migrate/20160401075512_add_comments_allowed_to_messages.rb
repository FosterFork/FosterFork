class AddCommentsAllowedToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :comments_allowed, :boolean, null: false, default: true
  end
end
