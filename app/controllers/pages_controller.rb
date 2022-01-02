class PagesController < ApplicationController
  before_action :authenticate_user!
  def home
    @projects = current_user.type == "Admin" ? Project.all : current_user.projects
    @members = Member.all
  end
end
