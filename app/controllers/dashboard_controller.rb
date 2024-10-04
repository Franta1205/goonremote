class DashboardController < ApplicationController
  def index
    complain unless current_user.admin
  end
end
