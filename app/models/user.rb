class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
  acts_as_tenant :organization
  has_one :payment
  accepts_nested_attributes_for :payment
  has_many :user_projects
  has_many :projects, through: :user_projects
end
