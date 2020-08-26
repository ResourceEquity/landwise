class AdminController < ApplicationController

  before_action :authenticate_user!

  before_action :authorize_admin!

  rescue_from CanCan::AccessDenied do |exception|
    render template: 'errors/unauthorized', layout: 'application'
  end

  def index
    if current_user.admin?
      redirect_to admin_records_path
    else
      redirect_to admin_users_path
    end
  end

  private

    def authorize_admin!
      if !current_user.admin? && !current_user.developer?
        raise ActionController::RoutingError, 'Not Found'
      end
    end

end
