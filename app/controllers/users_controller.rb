class UsersController < ApplicationController
  before_action :authorize_moderator, only: [:destroy, :new, :create]
  before_action :authorize_moderator, only: [:edit, :update], unless: :concerns_self
  prepend_before_action :set_user, only: [:show, :edit, :update, :destroy, :impersonate]
  decorates_assigned :user, :users

  # GET /users
  # GET /users.json
  def index
    @filter = params[:filter] if params.has_key? :filter and %w{unapproved invited}.include? params[:filter]

    if params[:search]
      @search = User.search { fulltext params[:search] }
      @users = user_query.where(id: @search.results.map(&:id))
    else
      @users = user_query.order(updated_at: :desc)
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/1/edit
  def edit
  end

  # PATCH/PUT /users/impersonate/1
  # PATCH/PUT /users/impersonate/1.json
  def impersonate
    impersonate_user(@user)
    redirect_to root_url
  end

  # PATCH/PUT /users/stop_impersonate/1
  # PATCH/PUT /users/stop_impersonate/1.json
  def stop_impersonating
    stop_impersonating_user
    redirect_to root_path
  end

  # PATCH/PUT /users/approve
  # PATCH/PUT /users/approve.json
  def approve
    User.where(id: params[:user_ids]).update_all(approved: true)

    respond_to do |format|
        format.html { redirect_to users_url(filter: "unapproved"), notice: 'Benutzer wurden freigeschaltet.' }
        format.json { head :no_content }
    end
  end

  # DELETE /users/abort_invitiation
  # DELETE /users/abort_invitiation.json
  def destroy_multiple
    User.where(id: params[:user_ids]).destroy_all

    respond_to do |format|
        format.html { redirect_to users_url(filter: "invited"), notice: 'Benutzer wurden gelöscht.' }
        format.json { head :no_content }
    end
  end


  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'Benutzer wurde erfolgreich aktualisiert.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private

  def set_user
    @user = User.friendly.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    allowed_params = [:username, :email, :jabber_id, :jabber_otr_fingerprint, :avatar]
    allowed_params << [:password, :password_confirmation] unless params[:user][:password].blank?
    allowed_params << [:role, :tenant_ids => []] if current_user.admin?
    allowed_params << [:user_ids => []] if current_user.moderator_or_admin?
    params.require(:user).permit(allowed_params)
  end

  def concerns_self
    @user.eql? current_user
  end

  def user_query
    case @filter
    when "unapproved"
      authorize_moderator
      User.unapproved
    when "invited"
      authorize_moderator
      User.invited
    else
      User.approved
    end.page(params[:page])
  end
end
