ActiveAdmin.register Project do
  scope :all
  scope :approved
  scope :unapproved
  scope :publicly_visible

  permit_params :owner, :category_id, :date, :recurrence,
                :address, :city, :zip, :country,
                :public, :approved, :active, :inquiries_allowed

  member_action :approve_project, method: :post do
    project = Project.friendly.find(params[:id])
    project.approved = true
    project.save!
    redirect_to [:admin, project], notice: "Project was approved."
  end

  index do
    selectable_column
    id_column

    column :owner, sortable: :owner_id
    column :category, sortable: :category_id
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
    column :approved

    actions
  end

  show title: :title do
    attributes_table do
      row :id

      row :owner
      row :category
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

    panel "Inquiries" do
      table_for project.inquiries do
        column :id do |inquiry|
          link_to inquiry.id, [:admin, inquiry]
        end
        column :content
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

    panel "Images" do
      table_for project.images do
        column :id do |image|
          link_to image.id, [:admin, image]
        end

        column :image do |image|
          link_to [:admin, image] do
            image_tag image.image.url(:normal), width: 200
          end
        end

        column :alt
      end
    end

    active_admin_comments
  end

  form do |f|
    f.inputs "Details" do
      f.input :owner
      f.input :category
      f.input :date
      f.input :recurrence
    end

    f.inputs "Texts" do
      f.input :title
      f.input :abstract
      f.input :description, as: :pagedown_text
    end

    f.inputs "Flags" do
      f.input :public
      f.input :approved
      f.input :active
      f.input :inquiries_allowed
    end

    f.inputs "Address" do
      f.input :address
      f.input :city
      f.input :zip
      f.input :country, as: :select, collection: selectable_countries
    end

    f.actions
  end

  sidebar :flags, only: :show do
    attributes_table do
      row :approved
      row :public
      row :inquiries_allowed
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
    unless project.approved?
      button_to "Approve Project", approve_project_admin_project_path(project)
    end
  end

end