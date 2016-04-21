ActiveAdmin.register Inquiry do
  permit_params :content

  show title: :id do
    attributes_table do
      row :id
      row :project
      row :user
      row :content
    end
  end

  sidebar :dates, only: :show do
    attributes_table do
      row :created_at
      row :updated_at
    end
  end

end