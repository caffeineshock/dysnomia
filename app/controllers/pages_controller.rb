class PagesController < ApplicationController
  include CrudListeners
  before_action :set_instance, only: [:show, :edit, :update, :destroy]
  decorates_assigned :pages

  # GET /pages
  # GET /pages.json
  def index
    @pages = Page.order(updated_at: :desc).page(params[:page])
    Page.mark_as_read! @pages.to_a, :for => current_user
  end

  # GET /pages/start
  # GET /pages/start.json
  def start
    redirect_to page_path(Page.startpage)
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
  end

  # GET /pages/new
  def new
    @page = Page.new
  end

  # GET /pages/1/edit
  def edit
  end

  # POST /pages
  # POST /pages.json
  def create
    @page = Page.new(page_params)

    respond_to do |format|
      if @page.save
        format.html { redirect_to @page, notice: 'Seite wurde erfolgreich erstellt.' }
        format.json { render action: 'show', status: :created, location: @page }
      else
        format.html { render action: 'new' }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pages/1
  # PATCH/PUT /pages/1.json
  def update
    respond_to do |format|
      if @page.update(page_params)
        format.html { redirect_to @page, notice: 'Seite wurde erfolgreich aktualisiert.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @page.destroy

    respond_to do |format|
      format.html { redirect_to pages_url }
      format.json { head :no_content }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def page_params
    allowed_params = [:title, :content]
    allowed_params << :startpage if current_user.moderator_or_admin?
    params.require(:page).permit(allowed_params)
  end

  def set_instance
    @page = Page.friendly.find(params[:id])
  end
end
