class Solr::ReindexJob < ApplicationJob

  queue_as :default

  def perform
    Record.reindex
    Guide.reindex
    Sunspot.commit(true)
  end
end
