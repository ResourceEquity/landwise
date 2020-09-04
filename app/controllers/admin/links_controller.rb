class Admin::LinksController < AdminController

  load_and_authorize_resource only: [:edit, :show, :update, :destroy]

  add_breadcrumb 'Broken Links', '/admin/links'

  def index
    @links = Link.accessible_by(current_ability, :read).where(ignore: false).order(created_at: :desc)
    authorize! :read, Link
  end

  def show; end

  def destroy
    @link.update(ignore: true)
    redirect_to admin_links_path, notice: "Link scanner will now ignore invalid responses for #{@link.url}"
  end

end
