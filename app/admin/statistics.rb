include ApplicationHelper

ActiveAdmin.register_page "Statistic plots" do
  menu label: "Statistic plots"

  content title: "Statistic plots" do
    [
      { data: :confirmed_users,           label: "Confirmed users" },
      { data: :projects,                  label: "Projects" },
      { data: :publicly_visible_projects, label: "Publicy visible projects" },
    ].each do |p|
      columns do
        column do
          panel p[:label] do
            div class: "statistic-plot", style: "height: 300px; width: 100%;", "data-statistics": Statistic.json_for_plot(p[:data])
          end
        end
      end
    end
  end
end
