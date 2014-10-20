class ReadListener
  def initialize user
    @user = user
  end

  def created subject
  	mark_subject_read subject
  end

  def read subject 
    mark_subject_read subject
  end

  def updated subject
  	mark_subject_read subject
  end

  def destroyed subject
  	PublicActivity::Activity.mark_as_read! subject.activities.to_a, for: @user
  end

  private

  def mark_subject_read subject
  	subject.mark_as_read! for: @user
    PublicActivity::Activity.mark_as_read! subject.activities.to_a, for: @user
  end
end