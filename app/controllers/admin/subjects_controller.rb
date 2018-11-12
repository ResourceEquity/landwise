class Admin::SubjectsController < AdminController

  load_and_authorize_resource only: [:edit, :update, :destroy]

  add_breadcrumb 'Subjects', '/admin/subjects'

  def index
    @subjects = Subject.all.order(title: :asc)
  end

  def new
    @subject = Subject.new
  end

  def edit; end

  def create
    @subject = Subject.new(subject_params)

    if @subject.save
      redirect_to admin_subjects_path, notice: "#{@subject.title} was created successfully."
    else
      flash! alert: @subject.errors.full_messages
      render :new
    end
  end

  def update
    if @subject.update(subject_params)
      redirect_to admin_subjects_path, notice: "#{@subject.title} was updated successfully."
    else
      flash! alert: @subject.errors.full_messages
      render :edit
    end
  end

  def destroy
    if @subject.destroy
      redirect_to admin_subjects_path, notice: "#{@subject.title} was deleted successfully."
    else
      redirect_to admin_subjects_path, alert: @subject.errors.full_messages
    end
  end

  private

    def subject_params
      params.require(:subject).permit(:title)
    end

end
