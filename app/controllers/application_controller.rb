class ApplicationController < ActionController::Base
  
  protect_from_forgery with: :exception

  before_action :check_redirect

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  add_breadcrumb 'Home', '/', unless: proc { self.class.name =~ /Admin/ }

  def check_redirect
    route = Redirect.find_by!(from: request.path)
    redirect_to route.to, status: :moved_permanently
  rescue ActiveRecord::RecordNotFound
    # Do nothing
  end

end
