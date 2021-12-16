class Project < ApplicationRecord
  acts_as_tenant :organization
  has_many :items, dependent: :destroy
end
