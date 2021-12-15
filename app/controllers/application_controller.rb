class ApplicationController < ActionController::Base
  set_current_tenant_by_subdomain_or_domain(:organization, :subdomain, :domain)

  def after_sign_in_path_for(resource)
    dashboard_path
  end
  

end
