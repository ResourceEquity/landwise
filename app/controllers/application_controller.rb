class ApplicationController < ActionController::Base
  
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end

  add_breadcrumb 'Home', '/', unless: proc { self.class.name =~ /Admin/ }

end
