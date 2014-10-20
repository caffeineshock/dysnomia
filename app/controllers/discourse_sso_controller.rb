class DiscourseSsoController < ApplicationController
  def index
    sso = SingleSignOnService.new(
        secret: current_tenant.settings(:discourse).sso_secret,
        query_string: request.query_string,
        user: current_user,
        base_url: "#{current_tenant.settings(:discourse).url}/session/sso_login"
    )

    redirect_to sso.redirect_url
  rescue RuntimeError
    raise "Bad Request"
  end
end