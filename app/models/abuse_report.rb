class AbuseReport < ActiveRecord::Base
  belongs_to :project
  belongs_to :reporter, class_name: :User
  belongs_to :resolver, class_name: :User

  validates_presence_of :project

  scope :unresolved, -> do
    AbuseReport.where(resolver: nil)
  end

  scope :resolved, ->do
    AbuseReport.where.not(resolver: nil)
  end

end
