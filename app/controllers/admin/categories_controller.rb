class Admin::CategoriesController < AdminController

  load_and_authorize_resource only: [:edit, :update, :destroy]

  add_breadcrumb 'Collection Types', '/admin/categories'

  def index
    @categories = Category.accessible_by(current_ability, :read).order(title: :asc)
    authorize! :read, Category
  end

  def new
    @category = Category.new
    authorize! :create, @category
  end

  def edit; end

  def create
    @category = Category.new(category_params)
    authorize! :create, @category

    if @category.save
      redirect_to admin_categories_path, notice: "#{@category.title} was created successfully."
    else
      flash! alert: @category.errors.full_messages
      render :new
    end
  end

  def update
    if @category.update(category_params)
      redirect_to admin_categories_path, notice: "#{@category.title} was updated successfully."
    else
      flash! alert: @category.errors.full_messages
      render :edit
    end
  end

  def destroy
    if @category.destroy
      redirect_to admin_categories_path, notice: "#{@category.title} was deleted successfully."
    else
      redirect_to admin_categories_path, alert: @category.errors.full_messages
    end
  end

  private

    def category_params
      params.require(:category).permit(:title)
    end

end
