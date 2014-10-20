class ActivityListener
  def initialize user
    @user = user
  end

  def created(subject)
  	create_activity subject, :create
  end

  def updated(subject)
    create_activity subject, :update
  end

  def destroyed(subject)
  	create_activity subject, :destroy
  end

  private

  def create_activity subject, action
    activity = subject.create_activity action, owner: @user
    activity.mark_as_read! for: @user
  end
end