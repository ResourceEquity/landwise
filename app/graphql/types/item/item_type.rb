module Types
  class Item::ItemType < Types::BaseObject

    field :id,          ID, null: false, description: 'ID of the record item. Should not normally be needed by anything'

    field :title,       String, null: false, cache: { key: :updated_at }, description: 'Title of the record item'
    field :description, String, null: true, cache: { key: :updated_at }, description: 'Description of the record item, may be null'
    field :website,     String, null: true, cache: { key: :updated_at }, description: 'URL to the item website, article, or document. May be null'
    field :document,    String, null: true, cache: { key: :updated_at }, description: 'Document attachment for the record item, if any. May be null. Difference between website and document is that document is downloaded, whereas website is simply linked to. Document links are only valid for 1 hour from time of query'

    field :year,        Integer, null: true, cache: { key: :updated_at }, description: 'Integer value of the year associated with the record item. May be null'

    field :languages,   [String], null: false, description: 'Array of language names associated with the record item'

    field :created_at,  GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at,  GraphQL::Types::ISO8601DateTime, null: false

    def languages
      object.languages.map(&:title)
    end

    def description
      object.description.blank? ? nil : object.description.strip
    end

    def website
      object.url.blank? ? nil : object.url.strip
    end

    def document
      object.document.attached? ? object.document.service_url(expires_in: 1.year, disposition: :attachment) : nil
    end

  end
end
