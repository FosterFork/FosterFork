class Message < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  has_many :comments, dependent: :destroy

  validates_presence_of :project
  validates_presence_of :user

  default_scope { order('updated_at DESC') }

  after_create :send_email

  def can_be_deleted_by?(user)
    return false if user.nil?
    return true if user.is_admin?
    return true if user == self.user
    return true if user == self.project.owner
    false
  end

  def can_be_comment_on_by?(user)
    return false if user.nil?
    return false unless self.comments_allowed
    return true if user == self.project.owner
    return true if user.participation_in(self.project)
    false
  end

  private

  def send_email
    self.project.send_message_mail(self)
  end

end
