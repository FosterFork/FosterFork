include LayoutHelper

ActiveAdmin.register TextBlock do
  permit_params :name, :title, :body, :locale, :public

  form do |f|
    inputs do
      input :name
      input :title
      input :body, as: :pagedown_text
      input :locale
      input :public
    end
    actions
  end

  index do
    selectable_column
    id_column

    column :name
    column :locale
    column :title
    column :body do |block|
      truncate block.body, length: 20
    end

    column :public
    column :updated_at

    actions
  end

  show title: :name do
    panel "Preview" do
      div do
        layout_render_textblock(text_block)
      end
    end
  end
end

