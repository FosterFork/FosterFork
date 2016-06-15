ActiveAdmin.register LayoutImage do
  permit_params :page, :locale, :alt, :image

  show title: :id do
    attributes_table do
      row :id
      row :page
      row :locale
      row :alt
    end

    panel :image do
      image_tag layout_image.image.url(:normal)
    end

    active_admin_comments
  end

  sidebar :dates, only: :show do
    attributes_table do
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs "Details" do
      f.input :page
      f.input :locale
      f.input :alt
      f.input :image, as: :file
    end

    f.actions
  end
end