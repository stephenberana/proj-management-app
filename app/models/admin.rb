class Admin < User
  devise :database_authenticatable, :validatable
  include DeviseInvitable::Inviter
end