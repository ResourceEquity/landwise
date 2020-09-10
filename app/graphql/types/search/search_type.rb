module Types
  class Search::SearchType < Types::BaseObject

    field :records,     [Types::Record::RecordType], null: false, description: 'List of search results'
    field :page_info,   Types::PageInfo::PageInfoType, null: false, description: 'Access to meta information relating to the current "page" of search results'
    field :updated_at,  GraphQL::Types::ISO8601DateTime, null: false, description: 'Reflects the most recently updated record in the search results'
    field :facets,      Types::Facet::FacetType, null: false, description: 'Facets bound by the current search'

    def records
      @records ||= search.results
    end
    
    def page_info
      ::PageInfo.new(
        current_page: records.current_page,
        total_pages: records.total_pages,
        total_results: search.total,
        per_page: [[object.per_page, 1].max, 200].min,
        prev_page: records.first_page? ? nil : records.current_page - 1,
        next_page: records.last_page? ? nil : records.current_page + 1
      )
    end
    
    def updated_at
      @updates ||= query(1, 1, :updated_at, :desc)
      @updates.results.first&.updated_at || Time.current
    end

    def facets
      ::Facet.new(search: search)
    end

    private

    def search
      @search ||= query(object.page, object.per_page, object.sort, object.direction)
    end

    def query(page, per_page, sort, direction)
      ::Record.search(include: [:category, :jurisdiction, :record_countries, :countries, :topics, { items: [:document_attachment] }]) do
        any do
          fulltext object.query || '*'
  
          if object.query.present?
            fulltext object.query.to_s.split(/\s+/).join(' OR '), fields: :creator
          end
        end

        facet :country_ids, :topic_ids, :language_ids, :category_id, :jurisdiction_id, limit: -1
  
        paginate page: page, per_page: 9999 # [[per_page, 1].max, 200].min
  
        if ['title_sort', 'updated_at', 'category_sort'].include?(sort)
          order_by sort, direction
        end
  
        with(:country_ids,  object.country_ids)  if object.country_ids.present?
        with(:topic_ids,    object.topic_ids)    if object.topic_ids.present?
        with(:language_ids, object.language_ids) if object.language_ids.present?
        with(:year,         object.years)        if object.years.present?
  
        if object.jurisdiction_ids.present?
          object.jurisdiction_ids.each do |jurisdiction_id|
            with :jurisdiction_id, jurisdiction_id
          end
        end
  
        if object.category_ids.present?
          object.category_ids.each do |category_id|
            with :category_id, category_id
          end
        end
  
        with :published, true

        with :roles, context[:current_user].responsibilities.map(&:id)
      end
    end

  end
end
