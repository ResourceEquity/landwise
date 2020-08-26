class Admin::JurisdictionsController < AdminController

  load_and_authorize_resource only: [:edit, :update, :destroy]

  add_breadcrumb 'Jurisdictions', '/admin/jurisdictions'

  def index
    @jurisdictions = Jurisdiction.accessible_by(current_ability, :read).order(title: :asc)
    authorize! :read, Jurisdiction
  end

  def new
    @jurisdiction = Jurisdiction.new
    authorize! :create, @jurisdiction
  end

  def edit; end

  def create
    @jurisdiction = Jurisdiction.new(jurisdiction_params)
    authorize! :create, @jurisdiction

    if @jurisdiction.save
      redirect_to admin_jurisdictions_path, notice: "#{@jurisdiction.title} was created successfully."
    else
      flash! alert: @jurisdiction.errors.full_messages
      render :new
    end
  end

  def update
    if @jurisdiction.update(jurisdiction_params)
      redirect_to admin_jurisdictions_path, notice: "#{@jurisdiction.title} was updated successfully."
    else
      flash! alert: @jurisdiction.errors.full_messages
      render :edit
    end
  end

  def destroy
    if @jurisdiction.destroy
      redirect_to admin_jurisdictions_path, notice: "#{@jurisdiction.title} was deleted successfully."
    else
      redirect_to admin_jurisdictions_path, alert: @jurisdiction.errors.full_messages
    end
  end

  private

    def jurisdiction_params
      params.require(:jurisdiction).permit(:title)
    end

end
