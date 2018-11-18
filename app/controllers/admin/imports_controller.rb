class Admin::ImportsController < AdminController

  load_and_authorize_resource only: [:show, :update, :destroy]

  add_breadcrumb 'Imports', '/admin/imports'

  def index
    @imports = Import.all.order(created_at: :desc)
  end

  def show; end

  def new
    @import = Import.new
  end

  def create
    @import = Import.new(import_params)
    @import.user = current_user

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
