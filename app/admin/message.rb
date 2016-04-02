ActiveAdmin.register Message do
  menu :if => proc { false }

  show title: :title do
    attributes_table do
      row :id
      row :project
      row :user
      row :title
      row :content
    end

    panel :comments do
      table_for message.comments do
        column :id do |comment|
          link_to comment.id, [:admin, comment]
        end

        column :user
        column :content do |comment|
          comment.content.truncate(200)
        end

        column :created_at
      end
    end
  end

  sidebar :flags, only: :show do
    attributes_table do
      row :comments_allowed
    end
  end

  sidebar :dates, only: :show do
    attributes_table do
      row :created_at
      row :updated_at
    end
  end

end