class Admin::TopicsController < AdminController

  load_and_authorize_resource only: [:edit, :update, :destroy]

  add_breadcrumb 'Topics', '/admin/topics'

  def index
    @topics = Topic.all.order(title: :asc)
    authorize! :read, Topic
  end

  def new
    @topic = Topic.new
    authorize! :create, @topic
  end

  def edit; end

  def create
    @topic = Topic.new(topic_params)
    authorize! :create, @topic

    if @topic.save
      redirect_to admin_topics_path, notice: "#{@topic.title} was created successfully."
    else
      flash! alert: @topic.errors.full_messages
      render :new
    end
  end

  def update
    if @topic.update(topic_params)
      redirect_to admin_topics_path, notice: "#{@topic.title} was updated successfully."
    else
      flash! alert: @topic.errors.full_messages
      render :edit
    end
  end

  def destroy
    if @topic.destroy
      redirect_to admin_topics_path, notice: "#{@topic.title} was deleted successfully."
    else
      redirect_to admin_topics_path, alert: @topic.errors.full_messages
    end
  end

  private

    def topic_params
      params.require(:topic).permit(:title)
    end

end
