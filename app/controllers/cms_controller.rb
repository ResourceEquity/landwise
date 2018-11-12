class CmsController < ApplicationController

  def show
    @page = Page.find_by!(slug: slug)
  rescue ActiveRecord::RecordNotFound
    raise ActionController::RoutingError, 'Not Found'
  end

  private

    def slug
      request.path.downcase.gsub(/(^[\/\s]+)|([\/\s]+$)/, '')
    end

end
