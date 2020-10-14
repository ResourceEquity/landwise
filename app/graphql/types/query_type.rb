module Types
  class QueryType < Types::BaseObject

    field :facets, Types::Facet::FacetType, null: false, description: 'Access to possible facets that can be filtered by in a search query'

    def facets
      ::Facet.new
    end

    field :records, [Types::Record::RecordType], null: false, description: 'List of records' do
      argument :record_ids, [ID], required: false, description: 'Array of specific record ids to fetch'
      argument :page,       Integer, required: false, description: 'Page number of records to return, starts at 0'
      argument :per_page,   Integer, required: false, description: 'Number of results per page, 1-200, default 50'
    end

    def records(record_ids: [], page: 0, per_page: 50)
      limit = [[per_page, 1].max, 200].min
      offset = limit * page

      if record_ids.any?
        @records ||= ::Record.where(id: Array.wrap(record_ids)).offset(offset).limit(limit)
      else
        @records ||= ::Record.all.order(id: :asc).offset(offset).limit(limit)
      end
    end

    field :search, Types::Search::SearchType, null: false, description: 'Performs a search of all accessible records' do
      argument :query,      String, required: false, description: 'Optional query search term'
      argument :page,       Integer, required: false, description: 'The page number of results to return, beginning with 1.'
      argument :per_page,   Integer, required: false, description: 'Number of results to return per page. The API strictly enforces a range of 1 - 200. Values outside this range will be overridden with the upper/lower bound, whichever is closest.'
      argument :sort,       String, required: false, description: 'Field to sort by. Can be one of: "title_sort", "updated_at", or "category_sort"'
      argument :direction,  String, required: false, description: 'Sort direction. Must be one of: "asc", "desc"'

      argument :country_ids,      [ID], required: false, description: 'Array of country ids with which to filter results'
      argument :topic_ids,        [ID], required: false, description: 'Array of topic ids with which to filter results'
      argument :language_ids,     [ID], required: false, description: 'Array of language ids with which to filter results'
      argument :jurisdiction_ids, [ID], required: false, description: 'Array of jurisdiction ids with which to filter results'
      argument :category_ids,     [ID], required: false, description: 'Array of category (collection type) ids with which to filter results'
      argument :years,            [Integer], required: false, description: 'Array of years with which to filter results'
    end

    def search(query: nil, page: 1, per_page: 100, sort: nil, direction: nil, country_ids: nil, topic_ids: nil, language_ids: nil, jurisdiction_ids: nil, category_ids: nil, years: nil)
      ::Search.new(
        query: query,
        page: page,
        per_page: per_page,
        sort: sort,
        direction: (['asc', 'desc'] & [direction.to_s.downcase]).first,
        country_ids: country_ids,
        topic_ids: topic_ids,
        language_ids: language_ids,
        jurisdiction_ids: jurisdiction_ids,
        category_ids: category_ids,
        years: years
      )
    end

  end
end
