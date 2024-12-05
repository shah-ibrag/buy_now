class AdminDashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin!

  def index
  end

  private

  def ensure_admin!
    redirect_to root_path, alert: "You are not authorized to access this page." unless current_user.admin?
  end
end