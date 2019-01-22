class GuidesController < ApplicationController

  def index
    session[:guides_crumb] = search_params

    @search = Guide.search do
      fulltext '*'

      data_accessor_for(Guide).include = [:guide_users, :users]

      facet :country_ids, :subject_ids, :user_ids, limit: -1

      order_by(search_params[:sort], sort_direction) if ['title_sort', 'updated_at'].include?(search_params[:sort])

      with(:user_ids,    search_filter(:user_ids))    if has_search_filter?(:user_ids)
      with(:subject_ids, search_filter(:subject_ids)) if has_search_filter?(:subject_ids)
      with(:country_ids, search_filter(:country_ids)) if has_search_filter?(:country_ids)

      with :published, true
    end
  end

  def show
    @guide = Guide.includes(articles: [:sections]).find(params[:id])

    raise ActionController::RoutingError, 'Not Found' unless @guide.published?

    @article = @guide.articles.first

    add_breadcrumb 'Practice Guides', guides_path(session[:guides_crumb])
    add_breadcrumb @guide.title, guide_article_path(@guide, @article)

    respond_to do |format|
      format.pdf  { send_data @guide.to_pdf, type: 'application/pdf', filename: "#{@guide.title.gsub(/[^a-z0-9\s_]+/i, '').gsub(/\s+/, '_').downcase}.pdf" }
      format.html { render template: 'articles/show' }
      format.view
    end
  end

  private

    def has_search_filter?(param)
      search_params[param].present?
    end

    def search_filter(param)
      search_params[param].to_s.split(',')
    end

    def search_params
      params.permit(:user_ids, :subject_ids, :country_ids, :sort)
    end

    def sort_direction
      if search_params[:sort] == :relevancy || Guide.columns_hash[search_params[:sort]].try(:type) == :datetime
        :desc
      else
        :asc
      end
    end
end