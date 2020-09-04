class HomeController < ApplicationController

  def index
    @announcements = Page.find_by(title: 'Announcements') || Page.new

    @search = Record.search(include: [:category, :record_countries, :countries]) do
      fulltext '*'
      paginate page: 1, per_page: 5
      order_by :created_at, :desc
    end

    @recent = @search.results
    
    @facets = Record.search(include: [:topics, :record_countries, :countries]) do
      fulltext '*'

      facet :country_ids, :topic_ids, limit: -1
    end

    country_ids = @facets.facet(:country_ids).rows.map(&:value)
    topic_ids = @facets.facet(:topic_ids).rows.map(&:value)

    @countries = Country.where(id: country_ids).order(title: :asc)
    @topics = Topic.where(id: topic_ids).order(title: :asc)
  end

end
