ActiveAdmin.register Project do

  member_action :approve_project, method: :post do
    project = Project.friendly.find(params[:id])
    project.approved = true
    project.save!
    redirect_to [:admin, project], notice: "Project was approved."
  end

  member_action :disapprove_project, method: :post do
    project = Project.friendly.find(params[:id])
    project.approved = false
    project.save!
    redirect_to [:admin, project], notice: "Project was disapproved."
  end

  index do
    selectable_column
    id_column

    column :owner, sortable: :owner_id
    column :title, sortable: :title
    column :date, sortable: :date
    column :recurrence, sortable: :recurrence

    column :participants do |project|
      project.participations.length
    end

    column :messages do |project|
      project.messages.length
    end

    column :public
    column :participation_wanted
    column :approved

    actions
  end

  show title: :title do
    attributes_table do
      row :id

      row :owner
      row :title
      row :slug

      row :abstract
      row :description, as: :pagedown

      row :date
      row :recurrence

      row :secret

      row :address
      row :city
      row :zip
      row :country

      row :latitude
      row :longitude
    end

    panel "Participations" do
      table_for project.participations do
        column :user
        column :created_at
      end
    end

    panel "Messages" do
      table_for project.messages do
        column :id do |message|
          link_to message.id, [:admin, message]
        end

        column :user
        column :title
        column :created_at
      end
    end
  end

  form do |f|
    f.inputs "Details" do
      f.input :owner
      f.input :date
      f.input :recurrence
    end

    f.inputs "Flags" do
      f.input :public
      f.input :approved
      f.input :active
      f.input :participation_wanted
    end

    f.inputs "Address" do
      f.input :address
      f.input :city
      f.input :zip
      f.input :country, as: :select, collection: selectable_countries
    end
  end

  sidebar :flags, only: :show do
    attributes_table do
      row :approved
      row :public
      row :participation_wanted
      row :active
    end
  end

  sidebar :dates, only: :show do
    attributes_table do
      row :created_at
      row :updated_at
    end
  end

  sidebar "Actions", only: :show do
    if project.approved?
      button_to "Disapprove Project", disapprove_project_admin_project_path(project)
    else
      button_to "Approve Project", approve_project_admin_project_path(project)
    end
  end

end