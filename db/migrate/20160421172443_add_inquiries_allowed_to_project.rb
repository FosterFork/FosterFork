class AddInquiriesAllowedToProject < ActiveRecord::Migration
  def change
    add_column :projects, :inquiries_allowed, :boolean, null: false, default: false
  end
end
