class Project < ActiveRecord::Base
  belongs_to :owner, class_name: :User
  belongs_to :category

  has_many :participations, dependent: :destroy
  has_many :users, through: :participations
  has_many :abuse_reports, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :images, dependent: :destroy

  RECURRENCE_TYPES = [ :none, :daily, :weekly, :biweekly, :monthly ]

  geocoded_by :full_street_address
  after_validation :geocode
  after_validation :after_validation_trigger
  before_create :generate_secret!

  extend FriendlyId
  friendly_id :title, use: :slugged

  validates_presence_of :owner
  validates_presence_of :category
  validates_presence_of :country

  validates_inclusion_of :recurrence, in: RECURRENCE_TYPES.map(&:to_s)

  validates_presence_of :title
  validates_length_of :title,       minimum: 8,  maximum: 80

  validates_presence_of :abstract
  validates_length_of :abstract,    minimum: 20, maximum: 400

  validates_presence_of :description
  validates_length_of :description, minimum: 20, maximum: 10000

  validates_presence_of :address
  validates_length_of :address,     minimum: 10, maximum: 100

  validates_presence_of :city
  validates_length_of :city,        minimum: 2,  maximum: 30

  validates_presence_of :zip
  validates_length_of :zip,         minimum: 4,  maximum: 10

  default_scope { includes(:owner, :participations) }

  scope :with_associations, -> do
    includes(:owner, :category, :participations, :images, messages: [ :user, { comments: :user }])
  end

  scope :publicly_visible, -> do
    where(public: true, approved: true, active: true).
    where("recurrence != 'none' OR date > ?", Time.now - 5.hours)
  end

  scope :approved, -> do
    where(approved: true)
  end

  scope :unapproved, -> do
    where(approved: false)
  end

  def full_street_address
    "#{self.address} #{self.zip} #{self.city} #{self.country}"
  end

  def after_validation_trigger
    if self.approved? and self.approved_changed?
      ProjectMailer.approved_mail(self).deliver_now!

      job = SendProjectNearYouJob.new
      job.async.perform(self)
    end
  end

  def next_date
    return self.date if self.date > Time.now

    interval =  case self.recurrence.to_sym
      when :none
        return self.date
      when :daily
        1.day
      when :weekly
        1.week
      when :biweekly
        2.weeks
      when :monthly
        1.month
    end

    diff = (Time.now - self.date) % interval
    Time.now + interval - diff
  end

  def last_update
    l = [ self.updated_at ]
    l.concat(self.messages.map(&:updated_at))
    l.sort { |a,b| a.to_i <=> b.to_i }.last
  end

  def accessible_by?(user, secret)
    # all projects can be accessed by their owners
    return true if self.owner == user

    # admins can do anything
    return true if user&.is_admin?

    # in any other case, the project must be active and approved
    if self.active? and self.approved?
      # a public project can be accessed by everyone
      return true if self.public?

      # if a user knows the secret, they have access as well
      return true if self.secret == secret

      # users who are participating already may also proceed
      return true if user and user.participation_in(self)
    end

    # the rest is locked out
    false
  end

  def to_ics
    project = self

    cal = RiCal.Calendar do
      event do
        summary project.title
        description project.abstract
        dtstart project.date
        dtend project.date
        location project.full_street_address
        if project.recurrence.to_sym != :none
          add_rrule "FREQ=#{project.recurrence.upcase}"
        end
      end
    end

    cal.export
  end

  def generate_secret!
    self.secret = SecureRandom.hex(16)
  end

  def send_message_mail(message)
    job = SendProjectMessagesJob.new
    job.async.perform(self, message)
  end

  def send_comment_mail(comment)
    job = SendProjectCommentsJob.new
    job.async.perform(self, comment)
  end

end
