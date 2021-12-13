class PagesController < ApplicationController
  before_action :authenticate_user!, :except => [:home]
  def home
    @projects = Project.all
  end
end
