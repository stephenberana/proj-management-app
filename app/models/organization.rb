class Organization < ApplicationRecord
    acts_as_universal_and_determines_tenant
    has_many: members, dependent: :destroy
    has_many :projects, dependent: :destroy
    has_one :payment
    accepts_nested_attributes_for :payment

  #defining plan roles via enum
    enum role: [:free, :premium]

    def org_is_in_db?(subdomain)
      organization = check_db(subdomain).exists?
    end
    
    def self.check_db(subdomain)
      where(subdomain: subdomain).first
    end
end
