ActiveAdmin.register Comment do
  menu :if => proc { false }
  permit_params :title, :content
end