class LibraryController < ApplicationController

  def index
    @search = Record.search do
      fulltext '*'
      facet :country_ids, :topic_ids, :language_ids, :category_id, :jurisdiction_id

      with :published, true

      if user_signed_in?
        with :roles, current_user.responsibilities.map(&:id)
      else
        with :roles, [Responsibility.find_by(title: 'Public').id]
      end
    end
  end

end
