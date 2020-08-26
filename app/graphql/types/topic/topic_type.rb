module Types
  class Topic::TopicType < Types::BaseObject

    field :id,          ID, null: false, description: 'ID of the topic, needed by the topicIds search parameter'

    field :title,       String, null: false, cache: { key: :updated_at }, description: 'Topic name'
    field :count,       Integer, null: true, cache: { key: :updated_at }, description: 'Count of records with this topic, may be null if not a part of a facet query'

    field :created_at,  GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at,  GraphQL::Types::ISO8601DateTime, null: false

  end
end
