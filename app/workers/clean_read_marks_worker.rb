class CleanReadMarksWorker
  include Sidekiq::Worker

  def perform
    %w{PublicActivity::Activity Task Event Page Message Upload}.each do |m|
      m.constantize.cleanup_read_marks!
    end
  end
end
