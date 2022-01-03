ActsAsTenant.configure do |config|
    config.require_tenant = true

    config.whitelist_organization_params = [:plan]
end