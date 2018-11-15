class Admin::RecordsController < AdminController

  load_and_authorize_resource only: [:edit, :update, :destroy]

  add_breadcrumb 'Records', '/admin/records'

  def index
    @search = Record.search do
      fulltext search_params[:q] || '*'

      paginate page: search_params[:page] || 1, per_page: search_params[:per] || 25
    end

    @records = @search.results
  end

  def new
    @record = Record.new
  end

  def edit; end

  def create
    @record = Record.new(record_params)

    if @record.save
      redirect_to admin_records_path, notice: "#{@record.title} was created successfully."
    else
      flash! alert: @record.errors.full_messages
      render :new
    end
  end

  def update
    if @record.update(record_params)
      redirect_to admin_records_path, notice: "#{@record.title} was updated successfully."
    else
      flash! alert: @record.errors.full_messages
      render :edit
    end
  end

  def destroy
    if @record.destroy
      redirect_to admin_records_path, notice: "#{@record.title} was deleted successfully."
    else
      redirect_to admin_records_path, alert: @record.errors.full_messages
    end
  end

  private

    def record_params
      params.require(:record).permit(
        :title,
        :creator,
        :description,
        :published,
        :notes,
        :author,
        :category_id,
        :jurisdiction_id,
        topic_ids: [],
        country_ids: [],
        responsibility_ids: [],
        items_attributes: [
          :id,
          :title,
          :year,
          :description,
          :url,
          :published,
          :document,
          :_destroy,
          language_ids: []
        ]
      )
    end

    def search_params
      params.permit(:q, :page, :per)
    end

end
