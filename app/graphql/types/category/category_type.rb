module Types
  class Category::CategoryType < Types::BaseObject

    field :id,            ID, null: false, description: 'ID of the category (collection type), needed by the categoryIds search parameter'

    field :title,         String, null: false, cache: { key: :updated_at }, description: 'Category (collection type) name'
    field :count,         Integer, null: true, cache: { key: :updated_at }, description: 'Count of records with this collection type, may be null if not a part of a facet query'

    field :created_at,    GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at,    GraphQL::Types::ISO8601DateTime, null: false

  end
end
