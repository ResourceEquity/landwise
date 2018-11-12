class RecordsController < ApplicationController

  def index
    session[:search_crumb] = search_params

    @search = Record.search do
      fulltext search_params[:q] || '*'

      data_accessor_for(Record).include = [:category, :record_countries, :countries]

      facet :country_ids, :topic_ids, :language_ids, :category_id, :jurisdiction_id

      paginate page: search_params[:page] || 1, per_page: search_params[:per] || 25

      order_by search_params[:sort] if ['title_sort', 'updated_at', 'category_sort'].include?(search_params[:sort])

      with(:country_ids,      search_filter(:country_ids))      if has_search_filter?(:country_ids)
      with(:topic_ids,        search_filter(:topic_ids))        if has_search_filter?(:topic_ids)
      with(:language_ids,     search_filter(:language_ids))     if has_search_filter?(:language_ids)
      with(:jurisdiction_id,  search_filter(:jurisdiction_id))  if has_search_filter?(:jurisdiction_id)
      with(:category_id,      search_filter(:category_id))      if has_search_filter?(:category_id)

      if user_signed_in?
        with :roles, current_user.responsibilities.map(&:id)
      else
        with :roles, [Responsibility.find_by(title: 'Public').id]
      end
    end
  end

  def show
    @record = Record.includes(items: [:languages, :item_languages, document_attachment: [:blob]]).find(params[:id])

    add_breadcrumb 'Search Results', records_path(session[:search_crumb])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @record }
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
      params.permit(:q, :country_ids, :topic_ids, :language_ids, :jurisdiction_id, :category_id, :page, :per, :sort)
    end
end
