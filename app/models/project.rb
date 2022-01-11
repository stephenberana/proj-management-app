class Project < ApplicationRecord
  acts_as_tenant :organization
  has_many :items, dependent: :destroy
  has_many :user_projects
  has_many :users, through: :user_projects
  validate :free_plan_can_only_have_one_project

  def free_plan_can_only_have_one_project
    if self.new_record? && (organization.projects.count > 0) && (organization.plan == 'free')
      errors.add(:base, "Free plans cannot have more than one project.")
    end
  end

  def self.by_user_plan_and_tenant(organization_id, user)
    organization = Organization.find(organization_id)
    if organization.plan == 'premium'
      if user.is_admin?
        organization.projects
      else
        user.projects.where(organization_id: organization.id)
      end
    else
      if user.is_admin?
        organization.projects.order(:id).limit(1)
      else
        user.projects.where(organization_id: organization.id).order(:id).limit(1)
      end
    end
  end
end
