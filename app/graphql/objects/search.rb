class Search

  attr_reader :query, :page, :per_page, :sort, :direction, :country_ids, :topic_ids, :language_ids, :jurisdiction_ids, :category_ids, :years

  def initialize(**args)
    args.each { |k, v| instance_variable_set("@#{k}", v) }
  end

end
