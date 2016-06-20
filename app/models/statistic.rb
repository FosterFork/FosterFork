class Statistic < ActiveRecord::Base
  validates_presence_of :data
  serialize :data

  SOURCES = {
    users: {
      proc:  -> { User.count },
      label: "Users",
    },
    confirmed_users: {
      proc:  -> { User.where.not(confirmed_at: nil).count },
      label: "Confirmed users",
    },
    projects: {
      proc:  -> { Project.count },
      label: "Projects",
    },
    publicly_visible_projects: {
      proc:  -> { Project.publicly_visible.count },
      label: "Publicly visible projects",
    },
    unresolved_abuse_reports: {
      proc:  -> { AbuseReport.where(resolver: nil).count },
      label: "Unresolved Abuse Reports",
    },
    resolved_abuse_reports: {
      proc:  -> { AbuseReport.where.not(resolver: nil).count },
      label: "Resolved Abuse Reports",
    },
    messages: {
      proc:  -> { Message.count },
      label: "Messages",
    },
    comments: {
      proc:  -> { Comment.count },
      label: "Comments",
    },
  }

  class << self
    def current
      data = {}

      SOURCES.each_pair do |k, v|
        data[k] = v[:proc].call
      end

      data
    end

    def snapshot
      create!(data: current)
    end

    def data_for_plot
      data = []
      return data unless all.any?

      c = current

      SOURCES.each_pair do |k, v|
        source_data = all.map do |stat|
          d = {}
          d[:date] = stat.created_at.to_i * 1000
          d[k] = stat.data[k]
          d
        end

        d = {}
        d[:date] = Time.now.to_i * 1000
        d[k] = c[k]
        source_data << d

        data << { data: source_data.to_json, label: v[:label] }
      end

      data
    end
  end

end
