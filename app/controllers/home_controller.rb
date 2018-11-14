class HomeController < ApplicationController

  def index
    @announcements = Page.find_by(title: 'Announcements') || Page.new

    @search = Record.search(include: [:category, :record_countries, :countries]) do
      fulltext '*'
      paginate page: 1, per_page: 5
      order_by :created_at, :desc
    end

    @recent = @search.results
  end

end
