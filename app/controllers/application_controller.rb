class ApplicationController < ActionController::Base
  set_current_tenant_by_subdomain_or_domain(:organization, :subdomain, :domain)
  devise_group :user, contains: [:admin, :member]
 
  def current_tenant
    @current_tenant ||= current_user.tenant unless current_user.nil?
  end

  helper_method :current_tenant

  def scope_current_tenant(&block)
    if current_tenant.nil?
      scope_visitor_schema
        yield
      else
        current_tenant.scope_schema("public", &block)
    end
  end

  def scope_visitor_schema()
      original_search_path = ActiveRecord::Base.connection.schema_search_path
      ActiveRecord::Base.connection.schema_search_path = 'public'
    ensure
      ActiveRecord::Base.connection.schema_search_path = original_search_path
  end

  def after_sign_in_path_for(resource)
    dashboard_path
  end
  
  def authenticate_inviter!
    authenticate_admin!(force: true)
  end
end
