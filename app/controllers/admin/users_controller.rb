class Admin::UsersController < AdminController

  load_and_authorize_resource only: [:edit, :update, :destroy]

  add_breadcrumb 'Users', '/admin/users'

  def index
    @search = User.search do
      fulltext search_params[:q] || '*'

      paginate page: search_params[:page] || 1, per_page: search_params[:per] || 25
    end

    @users = @search.results
  end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_users_path, notice: "#{@user.name} was created successfully."
    else
      flash! alert: @user.errors.full_messages
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "#{@user.name} was updated successfully."
    else
      flash! alert: @user.errors.full_messages
      render :edit
    end
  end

  def destroy
    if @user.destroy
      redirect_to admin_users_path, notice: "#{@user.name} was deleted successfully."
    else
      redirect_to admin_users_path, alert: @user.errors.full_messages
    end
  end

  private

    def user_params
      data = params.require(:user).permit(:first_name, :last_name, :title, :author, :email, :contact, :bio, :avatar, :password, :password_confirmation, responsibility_ids: [])
      data.delete_if { |k, v| k.to_s =~ /password/ && data[:password].blank? && data[:password_confirmation].blank? }
    end

    def search_params
      params.permit(:q, :page, :per)
    end

end
