module Types
  class Facet::FacetType < Types::BaseObject

    field :countries,     [Types::Country::CountryType], null: true, cache: { key: :updated_at }, description: 'Returns all unique countries across accessible records, sorted by title in ascending order'
    field :languages,     [Types::Language::LanguageType], null: true, cache: { key: :updated_at }, description: 'Returns all unique languages across accessible records, sorted by title in ascending order'
    field :topics,        [Types::Topic::TopicType], null: true, cache: { key: :updated_at }, description: 'Returns all unique topics across accessible records, sorted by title in ascending order'
    field :jurisdictions, [Types::Jurisdiction::JurisdictionType], null: true, cache: { key: :updated_at }, description: 'Returns all unique jurisdictions across accessible records, sorted by title in ascending order'
    field :categories,    [Types::Category::CategoryType], null: true, cache: { key: :updated_at }, description: 'Returns all unique categories (collection type) across accessible records, sorted by title in ascending order'

    def countries
      collection_for(:country_ids, ::Country)
    end

    def languages
      collection_for(:language_ids, ::Language)
    end

    def topics
      collection_for(:topic_ids, ::Topic)
    end

    def jurisdictions
      collection_for(:jurisdiction_id, ::Jurisdiction)
    end

    def categories
      collection_for(:category_id, ::Category)
    end

    private

    def facets
      @facets ||= object.search || ::Record.search do
        fulltext '*'
        facet :country_ids, :topic_ids, :language_ids, :category_id, :jurisdiction_id, limit: -1
  
        with :published, true

        with :roles, context[:current_user].responsibilities.map(&:id)
      end
    end

    def collection_for(facet, constructor)
      mapping = facets.facet(facet).rows.map { |f| { f.value => f.count } }.reduce(Hash.new, :merge)
  
      constructor.where(id: mapping.keys).order(title: :asc).map do |item|
        item.count = (mapping[item.id] || 0)
        item
      end
    end

  end
end
