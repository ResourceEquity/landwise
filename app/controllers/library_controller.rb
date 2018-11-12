class LibraryController < ApplicationController

  def index
    @search = Record.search do
      fulltext '*'
      facet :country_ids, :topic_ids, :language_ids, :category_id, :jurisdiction_id
    end
  end

end
