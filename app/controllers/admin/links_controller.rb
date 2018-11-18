class Admin::LinksController < AdminController

  load_and_authorize_resource only: [:edit, :update, :destroy]

  add_breadcrumb 'Link Checker', '/admin/links'

  def index
    @links = Link.all.order(created_at: :desc)
  end

end
