class ForumController < ApplicationController
  def index
    redirect_to root_url, alert: "Forum nicht konfiguriert" if forum_url.blank?
  end
end
