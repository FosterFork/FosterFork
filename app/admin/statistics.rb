include ApplicationHelper

ActiveAdmin.register_page "Statistic plots" do
  menu label: "Statistic plots"

  content title: "Statistic plots" do
    Statistic.data_for_plot.each do |p|
      columns do
        column do
          panel p[:label] do
            div class: "statistic-plot", style: "height: 300px; width: 100%;", "data-statistics": p[:data]
          end
        end
      end
    end
  end
end
