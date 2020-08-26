class Admin::RolesController < AdminController

  load_and_authorize_resource only: [:edit, :update, :destroy], class: 'Responsibility'

  add_breadcrumb 'Roles', '/admin/roles'

  def index
    @roles = Responsibility.accessible_by(current_ability, :read).order(title: :asc)
    authorize! :read, Responsibility
  end

  def new
    @role = Responsibility.new
    authorize! :create, @role
  end

  def edit; end

  def create
    @role = Responsibility.new(responsibility_params)
    authorize! :create, @role

    if @role.save
      redirect_to admin_roles_path, notice: "#{@role.title} was created successfully."
    else
      flash! alert: @role.errors.full_messages
      render :new
    end
  end

  def update
    if @role.update(responsibility_params)
      redirect_to admin_roles_path, notice: "#{@role.title} was updated successfully."
    else
      flash! alert: @role.errors.full_messages
      render :edit
    end
  end

  def destroy
    if @role.destroy
      redirect_to admin_roles_path, notice: "#{@role.title} was deleted successfully."
    else
      redirect_to admin_roles_path, alert: @role.errors.full_messages
    end
  end

  private

    def responsibility_params
      params.require(:responsibility).permit(:title)
    end

end
