class AdminController < ApplicationController

  before_action :authenticate_user!

  def index
    redirect_to admin_records_path
  end

end
