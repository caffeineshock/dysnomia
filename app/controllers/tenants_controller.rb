class TenantsController < ApplicationController
  before_action :authorize_admin
  before_action :set_tenant, only: [:show, :edit, :update, :destroy, :remove_logo, :remove_background]

  # GET /tenants
  # GET /tenants.json
  def index
    @tenants = Tenant.all
  end

  # GET /tenants/1
  # GET /tenants/1.json
  def show
  end

  # GET /tenants/new
  def new
    @tenant = Tenant.new
  end

  # GET /tenants/1/edit
  def edit
  end

  # POST /tenants
  # POST /tenants.json
  def create
    @tenant = Tenant.new(tenant_params)

    respond_to do |format|
      if @tenant.save
        format.html { redirect_to @tenant, notice: 'Tenant was successfully created.' }
        format.json { render action: 'show', status: :created, location: @tenant }
      else
        format.html { render action: 'new' }
        format.json { render json: @tenant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tenants/1
  # PATCH/PUT /tenants/1.json
  def update
    respond_to do |format|
      if @tenant.update(tenant_params)
        format.html { redirect_to @tenant, notice: 'Tenant was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @tenant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tenants/1
  # DELETE /tenants/1.json
  def destroy
    @tenant.destroy
    respond_to do |format|
      format.html { redirect_to tenants_url }
      format.json { head :no_content }
    end
  end

  def remove_logo
    @tenant.remove_attachment! :logo

    respond_to do |format|
      format.html { redirect_to @tenant, notice: 'Logo wurde erfolgreich entfernt.' }
      format.json { head :no_content }
    end
  end

  def remove_background
    @tenant.remove_attachment! :background

    respond_to do |format|
      format.html { redirect_to @tenant, notice: 'Hintergrundbild wurde erfolgreich entfernt.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_tenant
    @tenant = Tenant.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def tenant_params
    params.require(:tenant).permit(:name, :hostname, :logo, :background, :new_settings => {:discourse => [:url, :sso_secret, :api_key]})
  end
end
