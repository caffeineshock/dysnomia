class EventsController < ApplicationController
  include CrudListeners
  before_action :set_instance, only: [:add_exception, :show, :edit, :update, :destroy]
  decorates_assigned :event, :events

  # GET /events
  # GET /events.json
  # GET /events.ics
  def index
    if params[:start] and params[:end]
      @events = Event.eager.between(params[:start], params[:end])
    elsif params[:search]
      @search = Event.search { fulltext params[:search] }
      @events = Event.eager.where(id: @search.results.map(&:id))
    else
      @events = Event.eager.order(:starts_at)
    end

    Event.mark_as_read! @events.to_a, :for => current_user

    respond_to do |format|
      format.html { @events = @events.page(params[:page]) }
      format.xml { render :xml => @events }
      format.js { render :json => @events }
      format.ics { render :text => Event.as_calendar(@events) }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @event }
      format.js { render :json => @event }
      format.ics { render :text => Event.as_calendar([@event]) }
    end
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Termin wurde erfolgreich erstellt.' }
        format.json { render action: 'show', status: :created, location: @event }
      else
        format.html { render action: 'new' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def add_exception
    @event.add_exception params[:date]

    respond_to do |format|
      if @event.save
        @activity = PublicActivity::Activity.create({
          trackable: @event,
          key: "event.added_exception",
          parameters: {
            date: params[:date]
          },
          owner: current_user
        })
        @activity.mark_as_read! for: current_user
        PushNotificationService.new(current_user.id, current_tenant.id).push @activity, :add
        format.html { redirect_to calendar_url, notice: 'Ausnahme wurde erfolgreich erstellt.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Termin wurde erfolgreich aktualisiert.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to calendar_url }
      format.json { head :no_content }
    end
  end

  private

  def set_instance
    @event = Event.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params.require(:event).permit(:title, :description, :starts_at, :ends_at, :all_day, :category_id, :location, :recurring_type, :recurring_until, :schedule_exceptions => [], :user_ids => [])
  end
end
