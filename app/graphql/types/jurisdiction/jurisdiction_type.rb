module Types
  class Jurisdiction::JurisdictionType < Types::BaseObject

    field :id,            ID, null: false, description: 'ID of the jurisdiction, needed by the jurisdictionIds search parameter'

    field :title,       String, null: false, cache: { key: :updated_at }, description: 'Jurisdiction name'
    field :count,       Integer, null: true, cache: { key: :updated_at }, description: 'Count of records with this jurisdiction, may be null if not a part of a facet query'

    field :created_at,    GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at,    GraphQL::Types::ISO8601DateTime, null: false

  end
end
