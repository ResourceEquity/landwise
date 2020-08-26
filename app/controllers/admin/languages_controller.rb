class Admin::LanguagesController < AdminController

  load_and_authorize_resource only: [:edit, :update, :destroy]

  add_breadcrumb 'Languages', '/admin/languages'

  def index
    @languages = Language.accessible_by(current_ability, :read).order(title: :asc)
    authorize! :read, Language
  end

  def new
    @language = Language.new
    authorize! :create, @language
  end

  def edit; end

  def create
    @language = Language.new(language_params)
    authorize! :create, @language

    if @language.save
      redirect_to admin_languages_path, notice: "#{@language.title} was created successfully."
    else
      flash! alert: @language.errors.full_messages
      render :new
    end
  end

  def update
    if @language.update(language_params)
      redirect_to admin_languages_path, notice: "#{@language.title} was updated successfully."
    else
      flash! alert: @language.errors.full_messages
      render :edit
    end
  end

  def destroy
    if @language.destroy
      redirect_to admin_languages_path, notice: "#{@language.title} was deleted successfully."
    else
      redirect_to admin_languages_path, alert: @language.errors.full_messages
    end
  end

  private

    def language_params
      params.require(:language).permit(:title)
    end

end
