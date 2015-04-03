class PublicActivity::ActivityDecorator < Draper::Decorator
  delegate_all

  def initialize object, options = {}
    super object, options
    @first = false
  end

  def avatar
    h.image_tag object.owner.avatar.url(:small), class: "avatar small"
  end

  def first= first
    @first = first
  end

  def first?
    @first
  end

  def groups_with? other
    !other.nil? and
    object.created_at - other.created_at < 5.minutes and
    object.owner == other.owner
  end
end
