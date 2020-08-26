module Types
  class BaseObject < GraphQL::Schema::Object
    field_class Types::BaseField
    field_class GraphQL::Cache::Field
  end
end
