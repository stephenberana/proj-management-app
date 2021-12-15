class PagesController < ApplicationController
  before_action :authenticate_user!
  def home
    @projects = Project.all
    @members = Member.all
  end
end
