class TasksController < ApplicationController
  include CrudListeners
  before_action :set_instance, only: [:show, :edit, :update, :destroy]
  decorates_assigned :task, :tasks

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.where(completed: params.include?(:completed)).order(:due_at).page(params[:page])
    Task.mark_as_read! @tasks.to_a, :for => current_user
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Aufgabe wurde erfolgreich erstellt.' }
        format.json { render action: 'show', status: :created, location: @task }
      else
        format.html { render action: 'new' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Aufgabe wurde erfolgreich aktualisiert.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/complete
  # PATCH/PUT /tasks/complete.json
  def complete
    affected = Task.where(id: params[:task_ids]).update_all(completed: true)

    if affected > 0
      @activity = PublicActivity::Activity.create key: "task.complete", parameters: { affected: affected }, owner: current_user
      @activity.mark_as_read! for: current_user
      PushNotificationService.new(current_user.id, current_tenant.id).push @activity, :add
    end

    respond_to do |format|
        format.html { redirect_to tasks_url, notice: 'Aufgaben erfolgreich als erledigt markiert.' }
        format.json { head :no_content }
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy_multiple
    affected = Task.where(id: params[:task_ids]).destroy_all.size

    if affected > 0
      @activity = PublicActivity::Activity.create key: "task.destroy_multiple", parameters: { affected: affected }, owner: current_user
      @activity.mark_as_read! for: current_user
      PushNotificationService.new(current_user.id, current_tenant.id).push @activity, :add
    end

    respond_to do |format|
        format.html { redirect_to tasks_url(completed: "yes"), notice: 'Aufgaben erfolgreich gelöscht.' }
        format.json { head :no_content }
    end
  end

  private
  
  def set_instance
    @task = Task.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def task_params
    params.require(:task).permit(:title, :due_at, :completed, :user_ids => [])
  end
end
