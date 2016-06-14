class User < ActiveRecord::Base
  before_create :set_locale

  has_many :projects,  dependent: :destroy, foreign_key: :owner_id
  has_many :messages,  dependent: :destroy
  has_many :comments,  dependent: :destroy
  has_many :inquiries, dependent: :destroy

  has_many :participations, dependent: :destroy
  has_many :participating_projects, through: :participations, source: :project

  has_many :opened_abuse_reports, class_name: :AbuseReport, foreign_key: :reporter_id
  has_many :resolved_abuse_reports, class_name: :AbuseReport, foreign_key: :resolver_id

  attr_accessor :current_password
  attr_accessor :terms

  validates_presence_of :terms,   on: :create, allow_nil: false
  validates_acceptance_of :terms, on: :create, allow_nil: false

  validates_length_of :name, minimum: 4,  maximum: 25

  validates_presence_of :name
  validates_presence_of :email
  validates_format_of :email, with: /\A.+@.+\z/

  geocoded_by :zip_and_country
  after_validation :after_validation_trigger

  devise :database_authenticatable, :omniauthable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  def zip_and_country
    return nil if self.zip.blank? or self.country.blank?
    "#{self.zip} #{self.country}"
  end

  def participation_in(project)
    self.participations.where(project: project).first
  end

  def should_get_new_mail_about?(project)
    return false if self == project.owner
    return false if self.participation_in(project)
    return false if self.project_proximity.nil?
    return false unless self.confirmed?
    return false unless project.accessible_by?(self, nil)
    true
  end

  def password_required?
    # OAuth authenticated user don't need a password
    super && provider.blank?
  end

  class << self

    def from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token(50)
        user.name = auth.info.name || auth.info.nickname
      end
    end

    def new_with_session(params, session)
      if session["devise.user_attributes"]
        new(session["devise.user_attributes"], without_protection: true) do |user|
          user.attributes = params
          user.valid?
        end
      else
        super
      end
    end

  end

  private

  def after_validation_trigger
    self.geocode unless self.zip.blank? or self.country.blank?
    self.project_proximity = nil if self.project_proximity == 0
  end

  def set_locale
    self.locale = I18n.locale
  end

end
