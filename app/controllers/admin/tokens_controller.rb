class Admin::TokensController < AdminController

  load_and_authorize_resource only: [:edit, :show, :update, :destroy], class: 'AccessToken', parent: false
  
  add_breadcrumb 'API Keys', '/admin/tokens'
  
  def index
    @tokens = AccessToken.accessible_by(current_ability, :read).order(created_at: :desc)
  end

  def new
    @token = current_user.access_tokens.build
    authorize! :create, @token
  end
  
  def edit; end

  def create
    @token = current_user.access_tokens.build(token_params)
    authorize! :create, @token

    if @token.save
      redirect_to edit_admin_token_path(@token), notice: "#{@token.title} was created successfully."
    else
      flash! alert: @token.errors.full_messages
      render :new
    end
  end

  def update
    if @token.update(token_params)
      redirect_to edit_admin_token_path(@token), notice: "#{@token.title} was updated successfully."
    else
      flash! alert: @token.errors.full_messages
      render :edit
    end
  end

  def destroy
    if @token.destroy
      redirect_to admin_tokens_path, notice: "#{@token.title} was deleted successfully."
    else
      redirect_to admin_tokens_path, alert: @token.errors.full_messages
    end
  end

  private

    def token_params
      params.require(:access_token).permit(:title)
    end

end
