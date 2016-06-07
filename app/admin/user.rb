ActiveAdmin.register User do
  permit_params :email, :name, :phone, :zip, :country, :locale,
                :newsletter, :project_proximity, :is_admin,
                :latitude, :longitude, :uid, :provider

  index do
    selectable_column
    id_column
    column :name
    column :email
    column :provider
    column :created_at
    column :newsletter
    actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :email
      row :locale
      row :zip
      row :country
      row :project_proximity
    end

    panel "Owned projects" do
      table_for user.projects do
        column :title do |project|
          link_to project.title, [:admin, project]
        end
        column :created_at
      end
    end

    panel "Participations" do
      table_for user.participations do
        column :id do |p|
          link_to p.id, [:admin, p]
        end

        column :project
        column :created_at
      end
    end

    panel "Sent inquiries" do
      table_for user.inquiries do
        column :id do |inquiry|
          link_to inquiry.id, [:admin, inquiry]
        end
        column :content
        column :project
        column :created_at
      end
    end

    panel "Messages" do
      table_for user.messages do
        column :id do |message|
          link_to message.id, [:admin, message]
        end
        column :content
        column :project
        column :created_at
      end
    end

    panel "Comments" do
      table_for user.comments do
        column :id do |comment|
          link_to comment.id, [:admin, comment]
        end
        column :content
        column :message
        column :project do |comment|
          link_to comment.message.title, comment.message.project
        end

        column :created_at
      end
    end

    panel "Opened abuse reports" do
      table_for user.opened_abuse_reports do
        column :project
        column :reason
        column :created_at
      end
    end

    active_admin_comments
  end

  sidebar "Flags", only: :show do
    attributes_table do
      row :newsletter
      row :is_admin
    end
  end

  sidebar "Password reset", only: :show do
    attributes_table do
      row :reset_password_token
      row :reset_password_sent_at
    end
  end

  sidebar "Confirmation", only: :show do
    attributes_table do
      row :confirmation_token
      row :confirmed_at
      row :confirmation_sent_at
      row :unconfirmed_email
    end
  end

  sidebar "OAuth", only: :show do
    attributes_table do
      row :uid
      row :provider
    end
  end

  form do |f|
    f.inputs "User Details" do
      f.input :email
      f.input :name
      f.input :phone
      f.input :zip
      f.input :country, as: :select, collection: selectable_countries
      f.input :locale
      f.input :project_proximity
    end

    f.inputs "Flags" do
      f.input :newsletter
      f.input :is_admin
    end

    f.inputs "Location" do
      f.input :latitude
      f.input :longitude
    end

    f.inputs "Password and OAuth" do
      f.input :uid
      f.input :provider
    end

    f.actions
  end

end
