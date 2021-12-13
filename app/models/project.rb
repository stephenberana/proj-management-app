class Project < ApplicationRecord
  acts_as_tenant :organization
end
