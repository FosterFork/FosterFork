class Message < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  validates_presence_of :project
  validates_presence_of :user

  default_scope { order('created_at DESC') }

  after_save :send_email

  private

  def send_email
    self.project.send_message_mail(self)
  end

end
