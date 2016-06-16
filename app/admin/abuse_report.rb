ActiveAdmin.register AbuseReport do |c|

  scope :all
  scope :resolved
  scope :unresolved

  menu parent: "User Content"

  member_action :resolve_abuse_report, method: :post do
    abuse_report = AbuseReport.find(params[:id])
    abuse_report.resolver = current_user
    abuse_report.save!
    redirect_to [:admin, abuse_report], notice: "AbuseReport was resolved."
  end

  index do
    selectable_column
    id_column

    column :project
    column :reason do |ar|
      ar.reason.truncate(100) rescue ""
    end

    column :reporter
    column :resolver
    actions
  end

  sidebar "Actions", only: :show do
    if abuse_report.resolver.nil?
      button_to "Resolve Abuse Report", resolve_abuse_report_admin_abuse_report_path(abuse_report)
    end
  end

end