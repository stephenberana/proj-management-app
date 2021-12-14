class Tenant < ApplicationRecord

    acts_as_universal_and_determines_tenant
    has_many: members, dependent: :destroy
    has_many :projects, dependent: :destroy
    has_one :payment
    accepts_nested_attributes_for :payment
    
end
