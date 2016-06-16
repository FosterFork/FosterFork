class Statistic < ActiveRecord::Base
  validates_presence_of :data
  serialize :data

  SOURCES = [
    {
      proc:  -> { User.count },
      key:   :users,
      label: "Users",
    },
    {
      proc:  -> { User.where.not(confirmed_at: nil).count },
      key:   :confirmed_users,
      label: "Confirmed users",
    },
    {
      proc:  -> { Project.count },
      key:   :projects,
      label: "Projects",
    },
    {
      proc:  -> { Project.publicly_visible.count },
      key:   :publicly_visible_projects,
      label: "Publicly visible projects",
    },
    {
      proc:  -> { AbuseReport.where(resolver: nil).count },
      key:   :unresolved_abuse_reports,
      label: "Unresolved Abuse Reports",
    },
    {
      proc:  -> { AbuseReport.where.not(resolver: nil).count },
      key:   :resolved_abuse_reports,
      label: "Resolved Abuse Reports",
    },
    {
      proc:  -> { Message.count },
      key:   :messages,
      label: "Messages",
    },
    {
      proc:  -> { Comment.count },
      key:   :comments,
      label: "Comments",
    },
  ]

  class << self
    def snapshot
      data = {}

      SOURCES.each do |s|
        data[s[:key]] = s[:proc].call
      end

      create!(data: data)
    end

    def data_for_plot
      SOURCES.map do |source|
        key = source[:key]

        data = all.map do |stat|
          d = {}
          d[:date] = stat.created_at.to_i * 1000
          d[key] = stat.data[key]
          d
        end

        { data: data.to_json, label: source[:label] }
      end
    end
  end

end
