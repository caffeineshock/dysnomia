class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :registerable, :async, :invitable
  include PublicActivity::Common 
  include ActiveModel::Dirty
  extend FriendlyId

  # Virtual attribute for devise authentication with mail or username
  attr_accessor :login

  # Allow username as ID
  friendly_id :username

  # Unread
  acts_as_reader

  has_attached_file :avatar, styles: { medium: "48x48#", small: "24x24#", navbar: "27x27#" }, default_url: "avatar_missing_:style.png"
  
  validates_attachment :avatar, content_type: {content_type: /\Aimage\/.*\Z/}, size: {in: 0..200.kilobytes}
  validates :username, uniqueness: {case_sensitive:  false }, presence: true, length: { maximum: 20 }, format: { with: /\A[a-zA-Z0-9]+\Z/ }
  validates :email, uniqueness: true, presence: true, length: { maximum: 100 }

  has_many :participations, dependent: :destroy
  has_many :events, through: :participations
  has_many :subscriptions, dependent: :destroy
  has_many :channels, through: :subscriptions
  has_many :tenants, through: :memberships
  has_many :memberships, dependent: :destroy
  has_many :activities, class_name: 'PublicActivity::Activity', foreign_key: 'owner_id', dependent: :destroy

  before_create :generate_access_token, :add_current_tenant
  before_save :synchronize_with_discourse

  enum role: [:user, :moderator, :admin]

  scope :viewable_from_tenant, -> { includes(:tenants).where(tenants: {id: Tenant.current_id}) }

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  def self.invited
    viewable_from_tenant.invitation_not_accepted
  end

  def self.moderators
    viewable_from_tenant.where(role: User.roles[:moderator]).order("last_sign_in_at DESC")
  end

  def self.admins
    viewable_from_tenant.where(role: User.roles[:admin]).order("last_sign_in_at DESC")
  end

  def self.approved
    viewable_from_tenant.where(approved: true).order("current_sign_in_at DESC")
  end

  def self.unapproved
    viewable_from_tenant.where.not(approved: true).where(invitation_token: nil).order("users.created_at DESC")
  end

  def self.not_subscribed_to channel
    viewable_from_tenant.where.not(id: channel.users.pluck(:id), approved: false)
  end

  def self.send_reset_password_instructions(attributes={})
    recoverable = find_or_initialize_with_errors(reset_password_keys, attributes, :not_found)
    if !recoverable.approved?
      recoverable.errors[:base] << I18n.t("devise.failure.not_approved")
    elsif recoverable.persisted?
      recoverable.send_reset_password_instructions
    end
    recoverable
  end

  def access_to_current_tenant?
    tenants.pluck(:id).include?(Tenant.current_id) or admin?
  end

  def active_for_authentication? 
    super && approved? && access_to_current_tenant?
  end 

  def inactive_message 
    if !approved?
      :not_approved
    elsif !access_to_current_tenant?
      :not_part_of_organization
    else 
      super # Use whatever other message 
    end 
  end

  def moderator_or_admin?
    moderator? || admin?
  end

  def online?
    !current_sign_in_at.nil? and current_sign_in_at > 5.minutes.ago
  end

  def can_edit? user
    return admin? if user.admin?
    return user == self || moderator? || admin?
  end

  private

  def synchronize_with_discourse
    DiscourseSynchronizationWorker.perform_async(id, username_was)
  end

  def add_current_tenant
    tenants << Tenant.find(Tenant.current_id)
  end

  def generate_access_token
    begin
      self.access_token = SecureRandom.hex
    end while self.class.exists?(access_token: access_token)
  end
end