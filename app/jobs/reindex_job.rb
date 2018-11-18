class ReindexJob < ApplicationJob

  queue_as :default

  def perform
    Record.reindex
    Guide.reindex
    User.reindex
    Sunspot.commit(true)
  end
end
