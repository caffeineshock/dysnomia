class Tenant < ActiveRecord::Base
  attr_writer :new_settings

  has_settings :discourse, :appearance
  has_many :users, through: :memberships
  has_many :memberships, dependent: :destroy

  has_attached_file :logo, styles: { navbar: "x27" }
  has_attached_file :background

  validates_attachment_content_type :logo, content_type: /\Aimage/
  validates_attachment_content_type :background, content_type: /\Aimage/

  validates :name, uniqueness: {case_sensitive:  false }, presence: true, length: { maximum: 100 }
  validates :hostname, uniqueness: {case_sensitive:  false }, presence: true, length: { maximum: 200 }

  after_save :save_settings
  after_create :seed_tenant

  def self.current_id=(id)
    Thread.current[:tenant_id] = id
  end

  def self.current_id
    Thread.current[:tenant_id]
  end

  def self.accessable user
    (user.admin? ? Tenant.all : Tenant.where(id: user.tenants.pluck(:id))).order(:name)
  end

  def url
    Settings.hostname_scheme % {hostname: hostname}
  end

  def remove_attachment! type
    send(type).clear
    save
  end

  private

  def save_settings
    @new_settings.each do |k,v|
      settings(k.to_sym).update_attributes! v
    end unless @new_settings.nil?
  end

  def seed_tenant
    Page.unscoped.create({
      tenant_id: id,
      startpage: true,
      title: "Startseite",
      content: "Das ist die erste Seite, die im **Wiki** angezeigt wird..."
    })

    Category.unscoped.create({
      tenant_id: id,
      title: "(Keine Kategorie)",
      color: "#6b6b6b"
    })
  end
end
