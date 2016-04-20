ActiveAdmin.register Category do
  permit_params :name, :color, :priority, translations_attributes: [ :id, :locale, :title ]

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

    panel "Translations" do
      table_for category.translations do
        column :locale
        column :title
      end
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

  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :color
      f.input :priority
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