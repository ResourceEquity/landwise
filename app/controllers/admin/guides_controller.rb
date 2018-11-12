class Admin::GuidesController < AdminController

  load_and_authorize_resource only: [:edit, :update, :destroy]

  add_breadcrumb 'Guides', '/admin/guides'

  def index
    @search = Guide.search do
      fulltext search_params[:q] || '*'

      paginate page: search_params[:page] || 1, per_page: search_params[:per] || 25
    end

    @guides = @search.results
  end

  def new
    @guide = Guide.new
  end

  def edit; end

  def create
    @guide = Guide.new(guide_params)

    if @guide.save
      redirect_to admin_guides_path, notice: "#{@guide.title} was created successfully."
    else
      flash! alert: @guide.errors.full_messages
      render :new
    end
  end

  def update
    if @guide.update(guide_params)
      redirect_to admin_guides_path, notice: "#{@guide.title} was updated successfully."
    else
      flash! alert: @guide.errors.full_messages
      render :edit
    end
  end

  def destroy
    if @guide.destroy
      redirect_to admin_guides_path, notice: "#{@guide.title} was deleted successfully."
    else
      redirect_to admin_guides_path, alert: @guide.errors.full_messages
    end
  end

  private

    def guide_params
      params.require(:guide).permit(
        :title,
        :published,
        user_ids: [],
        subject_ids: [],
        country_ids: [],
        articles_attributes: [
          :id,
          :title,
          :position,
          :_destroy,
          sections_attributes: [:id, :title, :body, :position, :_destroy]
        ]
      )
    end

    def search_params
      params.permit(:q, :page, :per)
    end

end
