class AbuseReport < ActiveRecord::Base
  belongs_to :project
  belongs_to :reporter, class_name: :User
  belongs_to :resolver, class_name: :User

  validates_presence_of :project

  after_create :send_email

  scope :unresolved, -> do
    AbuseReport.where(resolver: nil)
  end

  scope :resolved, ->do
    AbuseReport.where.not(resolver: nil)
  end

  private

  def send_email
    if Settings.notification_emails&.new_abuse_report
      AdminMailer.new_abuse_report_mail(self, Settings.notification_emails.new_abuse_report).deliver_now
    end
  end

end
