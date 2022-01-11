class Project < ApplicationRecord
  acts_as_tenant :organization
  has_many :items, dependent: :destroy
  has_many :user_projects
  has_many :users, through: :user_projects
  has_many :artifacts
  has_many :tasks
  has_many :items
end
