module ApplicationHelper

  def query
    @query ||= begin
      url = request.base_url + request.original_fullpath
      uri = URI.parse(url)

      Rack::Utils.parse_query(uri.query)
    end
  end

  def collection_for(facet, constructor=nil)
    ids = Array(query["#{facet}[]"] || query[facet.to_s]).map(&:to_s)

    mapping = @search.facet(facet).rows.map { |f| { f.value => f.count } }.reduce(Hash.new, :merge)

    if constructor.present?
      constructor.where(id: mapping.keys).order(title: :asc).each do |item|
        next if ids.include?(item.id.to_s)
        yield item, item, (mapping[item.id] || 0)
      end
    else
      mapping.to_a.sort_by { |r| r[0] }.reverse.each do |title, count|
        next if ids.include?(title.to_s)
        label = title
        label = 'Unknown' if facet == :year && title == 9999
        yield label, title, count
      end
    end
  end

  def has_facets_for?(facet)
    (@search.facet(facet).rows.map(&:value) - Array(query["#{facet}[]"] || query[facet.to_s]).map(&:to_i)).any?
  end

  def has_filters?(*fields)
    (params.keys & fields.map(&:to_s)).any?
  end

  def current_filters(**mapping)
    mapping.map do |filter_param, model|
      filter_ids = Array(params[filter_param]).compact.map(&:to_i)

      if filter_ids.any?
        if model.present?
          results = model.where(id: filter_ids)

          results.map do |result|
            if filter_ids.one?
              [result, replace_query_params(filter_param => nil), filter_param, params[filter_param]]
            else
              [result, replace_query_params(filter_param => filter_ids - [result.id]), filter_param, params[filter_param]]
            end
          end
        else
          labels = filter_ids.map do |value|
            { value: value, label: filter_param == :year && value == 9999 ? 'Unknown' : value }
          end
          if labels.one?
            [[OpenStruct.new(label: labels.first[:label]), replace_query_params(filter_param => nil), filter_param, params[filter_param]]]
          else
            labels.map do |result|
              [OpenStruct.new(label: result[:label]), replace_query_params(filter_param => filter_ids - [result[:value]]), filter_param, params[filter_param]]
            end
          end
        end
      end
    end.compact.flatten(1).each { |filter| yield(filter[0], filter[1], filter[2], filter[3]) }
  end

  def stylize(**flags)
    flags.select { |_, v| v }.keys.map { |k| k.to_s.dasherize }.join(' ')
  end

  def cms_pages
    Page.all.where(show_in_menu: true).order(position: :asc)
  end

end
