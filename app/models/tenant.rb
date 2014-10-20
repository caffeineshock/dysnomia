class Tenant < ActiveRecord::Base
  attr_writer :new_settings

  has_settings :discourse, :appearance
  has_many :users, through: :memberships
  has_many :memberships, dependent: :destroy

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
