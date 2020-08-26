module Types
  class PageInfo::PageInfoType < Types::BaseObject

    field :current_page,  Integer, null: false, description: 'Returns the current page number, starting with 1'
    field :total_pages,   Integer, null: false, description: 'Returns the total number of pages available'
    field :total_results, Integer, null: false, description: 'Returns the total number of results within the collection, across all available pages'
    field :per_page,      Integer, null: false, description: 'Returns the current number of results per page, bounded by the limits (1 - 200)'
    field :prev_page,     Integer, null: true, description: 'Returns the previous page number, if available. Null if currentPage is the first page'
    field :next_page,     Integer, null: true, description: 'Returns the next page number, if available. Null if currentPage is the last page'

  end
end
