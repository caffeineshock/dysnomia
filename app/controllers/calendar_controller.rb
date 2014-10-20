class CalendarController < ApplicationController
  # GET /calendar
  # GET /calendar.json
  def index
    respond_to do |format|
      format.html # index.html.erb
    end
  end
end
