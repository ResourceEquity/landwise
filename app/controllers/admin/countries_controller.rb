class Admin::CountriesController < AdminController

  load_and_authorize_resource only: [:edit, :update, :destroy]

  add_breadcrumb 'Countries', '/admin/countries'

  def index
    @countries = Country.all.order(title: :asc)
  end

  def new
    @country = Country.new
  end

  def edit; end

  def create
    @country = Country.new(country_params)

    if @country.save
      redirect_to admin_countries_path, notice: "#{@country.title} was created successfully."
    else
      flash! alert: @country.errors.full_messages
      render :new
    end
  end

  def update
    if @country.update(country_params)
      redirect_to admin_countries_path, notice: "#{@country.title} was updated successfully."
    else
      flash! alert: @country.errors.full_messages
      render :edit
    end
  end

  def destroy
    if @country.destroy
      redirect_to admin_countries_path, notice: "#{@country.title} was deleted successfully."
    else
      redirect_to admin_countries_path, alert: @country.errors.full_messages
    end
  end

  private

    def country_params
      params.require(:country).permit(:title)
    end

end
