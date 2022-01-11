class Task < ApplicationRecord
  belongs_to :project
  belongs_to :artifact
end
