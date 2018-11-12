class ArticlesController < ApplicationController

  def show
    @guide = Guide.find(params[:guide_id])
    @article = Article.find(params[:id])

    add_breadcrumb 'Practice Guides', guides_path(session[:guides_crumb])
    add_breadcrumb @guide.title, guide_path(@guide)
  end

end
