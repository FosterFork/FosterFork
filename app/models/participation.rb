class Participation < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  validates_presence_of :user
  validates_presence_of :project

  before_save :generate_secret!

  private

  def generate_secret!
    self.secret = SecureRandom.hex(16)
  end

end
