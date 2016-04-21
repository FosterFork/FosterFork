class Inquiry < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  validates_presence_of :project
  validates_presence_of :user

  after_create :send_email

  private

  def send_email
    ProjectMailer.inquiry_mail(self).deliver_now
  end

end
