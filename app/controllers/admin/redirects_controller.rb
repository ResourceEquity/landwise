class Admin::RedirectsController < AdminController

  load_and_authorize_resource only: [:edit, :update, :destroy]

  add_breadcrumb 'Redirects', '/admin/redirects'

  def index
    @redirects = Redirect.accessible_by(current_ability, :read).order(from: :asc)
    authorize! :read, Redirect
  end

  def new
    @redirect = Redirect.new
    authorize! :create, @redirect
  end

  def edit; end

  def create
    @redirect = Redirect.new(redirect_params)
    authorize! :create, @redirect

    if @redirect.save
      redirect_to admin_redirects_path, notice: "Redirect from \"#{@redirect.from}\" to \"#{@redirect.to}\" was created successfully."
    else
      flash! alert: @redirect.errors.full_messages
      render :new
    end
  end

  def update
    if @redirect.update(redirect_params)
      redirect_to admin_redirects_path, notice: "Redirect from \"#{@redirect.from}\" was updated successfully."
    else
      flash! alert: @redirect.errors.full_messages
      render :edit
    end
  end

  def destroy
    if @redirect.destroy
      redirect_to admin_redirects_path, notice: "Redirect from \"#{@redirect.from}\" was deleted successfully."
    else
      redirect_to admin_redirects_path, alert: @redirect.errors.full_messages
    end
  end

  private

    def redirect_params
      params.require(:redirect).permit(:from, :to)
    end

end
