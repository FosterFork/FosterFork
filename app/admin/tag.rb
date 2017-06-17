ActiveAdmin.register Tag do
  permit_params :name, :color, translations_attributes: [ :id, :locale, :title ]

  menu parent: "Admin Content"

  index do
    id_column
    column :name
    column :color
    actions
  end

  show title: :name do
    attributes_table do
      row :id
      row :name
      row :slug
      row :color
    end

    panel "Translations" do
      table_for tag.translations do
        column :locale
        column :title
      end
    end

    panel "Projects" do
      table_for tag.projects do
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

  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :color
    end

    f.inputs do
      f.has_many :translations, allow_destroy: true do |t|
        t.input :locale
        t.input :title
      end
    end

    f.actions
  end

end
