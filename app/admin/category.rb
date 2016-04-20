ActiveAdmin.register Category do
  permit_params :name, :color, :priority

  index do
    id_column
    column :name
    column :color
    column :priority
    actions
  end

  show title: :name do
    attributes_table do
      row :id
      row :name
      row :color
      row :priority
    end

    panel "Projects" do
      table_for category.projects do
        column :title do |project|
          link_to project.title, [:admin, project]
        end
        column :owner do |project|
          link_to project.owner.name, [:admin, project.owner]
        end
      end
    end
  end

  sidebar :dates, only: :show do
    attributes_table do
      row :created_at
      row :updated_at
    end
  end

end