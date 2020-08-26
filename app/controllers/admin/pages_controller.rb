class Admin::PagesController < AdminController

  load_and_authorize_resource only: [:edit, :update, :destroy]

  add_breadcrumb 'Pages', '/admin/pages'

  def index
    @pages = Page.accessible_by(current_ability, :read).order(title: :asc)
    authorize! :read, Page
  end

  def new
    @page = Page.new
    authorize! :create, @page
  end

  def edit; end

  def create
    @page = Page.new(page_params)
    authorize! :create, @page

    if @page.save
      redirect_to admin_pages_path, notice: "#{@page.title} was created successfully."
    else
      flash! alert: @page.errors.full_messages
      render :new
    end
  end

  def update
    if @page.update(page_params)
      redirect_to admin_pages_path, notice: "#{@page.title} was updated successfully."
    else
      flash! alert: @page.errors.full_messages
      render :edit
    end
  end

  def destroy
    if @page.destroy
      redirect_to admin_pages_path, notice: "#{@page.title} was deleted successfully."
    else
      redirect_to admin_pages_path, alert: @page.errors.full_messages
    end
  end

  private

    def page_params
      params.require(:page).permit(:title, :keywords, :description, :body, :slug, :position, :show_in_menu)
    end

end
