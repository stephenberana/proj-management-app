class InvitationsController < Devise::InvitationsController
    prepend_before_action :find_tenant_by_subdomain_or_domain
end