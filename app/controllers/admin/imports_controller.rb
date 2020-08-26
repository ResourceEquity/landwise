class Admin::ImportsController < AdminController

  load_and_authorize_resource only: [:show, :update, :destroy]

  add_breadcrumb 'Imports', '/admin/imports'

  def index
    @imports = Import.accessible_by(current_ability, :read).order(created_at: :desc)
    authorize! :read, Import
  end

  def show; end

  def new
    @import = Import.new
    authorize! :create, @import
  end

  def create
    @import = Import.new(import_params)
    @import.user = current_user
    authorize! :create, @import

    if @import.save
      ImportJob.perform_later(@import)
      redirect_to admin_imports_path, notice: "Import was enqueued successfully. A notification will be sent to #{current_user.email} when processing is completed."
    else
      flash! alert: @import.errors.full_messages
      render :new
    end
  end

  def update
    @import.import_errors.destroy_all
    ImportJob.perform_later(@import)
    redirect_to admin_imports_path, notice: "Import was reenqueued successfully. A notification will be sent to #{current_user.email} when processing is completed."
  end

  private

    def import_params
      params.require(:import).permit(:import)
    end

end
