class HomeController < ApplicationController

  def index
    @search = Record.search do
      fulltext '*'
      paginate page: 1, per_page: 5
      order_by :created_at, :desc
    end

    @recent = @search.results
  end

end
