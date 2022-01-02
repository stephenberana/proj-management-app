class ApplicationController < ActionController::Base
  set_current_tenant_by_subdomain_or_domain(:organization, :subdomain, :domain)
  devise_group :user, contains: [:admin, :member]
 
  def after_sign_in_path_for(resource)
    dashboard_path
  end
  
  def authenticate_inviter!
    authenticate_admin!(force: true)
  end

  def current_project (project_id)
     @current_project ||= Project.find( project_id )
  end

end
