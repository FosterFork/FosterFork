ActiveAdmin.register Project do

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

end