module Types
  class Record::RecordType < Types::BaseObject

    field :id, ID, null: false

    field :url,           String, null: false, cache: { key: :updated_at }
    field :title,         String, null: true, cache: { key: :updated_at }
    field :creator,       String, null: true, cache: { key: :updated_at }
    field :description,   String, null: true, cache: { key: :updated_at }
    field :author,        String, null: true, cache: { key: :updated_at }
    field :notes,         String, null: true, cache: { key: :updated_at }
    field :category,      String, null: true
    field :jurisdiction,  String, null: true

    field :topics,            [String], null: false
    field :countries,         [String], null: false
    field :items,             [Types::Item::ItemType], null: false

    field :created_at,    GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at,    GraphQL::Types::ISO8601DateTime, null: false

    def url
      Rails.application.routes.url_helpers.record_url(object, protocol: 'https')
    end

    def category
      object.category&.title
    end

    def jurisdiction
      object.jurisdiction&.title
    end

    def topics
      object.topics.map(&:title)
    end

    def countries
      object.countries.map(&:title)
    end

  end
end
