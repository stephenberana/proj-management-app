class Artifact < ApplicationRecord
  belongs_to :project
  has_many :tasks
  validates :name, presence: true, uniqueness: true
end
