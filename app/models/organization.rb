class Organization < ApplicationRecord
    def org_is_in_db?(subdomain)
      organization = check_db(subdomain).exists?
    end
    
    def self.check_db(subdomain)
      where(subdomain: subdomain).first
    end
end
