class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :message

  validates_presence_of :user
  validates_presence_of :message

  default_scope { order('updated_at DESC') }

  after_create :send_email

  def can_be_deleted_by?(user)
    return true if self.message.can_be_deleted_by? user
    return true if user == self.user
    false
  end

  private

  def send_email
#    self.project.send_message_mail(self)
  end

end
