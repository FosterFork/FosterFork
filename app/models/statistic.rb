class Statistic < ActiveRecord::Base
  validates_presence_of :data
  serialize :data

  def self.snapshot
    create!(data: {
      users: User.count,
      confirmed_users: User.where.not(confirmed_at: nil).count,
      projects: Project.count,
      publicly_visible_projects: Project.publicly_visible.count,
      unresolved_abuse_reports: AbuseReport.where(resolver: nil).count,
      resolved_abuse_reports: AbuseReport.where.not(resolver: nil).count,
      messages: Message.count,
      comments: Comment.count,
    })
  end

  def self.json_for_plot(key = nil)
    data = all.map do |s|
      d = { date: s.created_at.to_i * 1000 }

      if key
        d[key] = s.data[key]
      else
        d.merge! s.data
      end

      d
    end

    data.to_json
  end
end
