class Admin::LinksController < AdminController

  load_and_authorize_resource only: [:edit, :show, :update, :destroy]

  add_breadcrumb 'Link Checker', '/admin/links'

  def index
    @links = Link.accessible_by(current_ability, :read).order(created_at: :desc)
    authorize! :read, Link
  end

  def show; end

end
