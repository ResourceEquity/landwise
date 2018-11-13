class AdminController < ApplicationController

  before_action :authenticate_user!

  before_action :authorize_admin!

  def index
    redirect_to admin_records_path
  end

  private

    def authorize_admin!
      raise ActionController::RoutingError, 'Not Found' unless current_user.admin?
    end

end
