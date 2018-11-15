module ApplicationHelper

  def collection_for(facet, constructor=nil)
    mapping = @search.facet(facet).rows.map { |f| { f.value => f.count } }.reduce(Hash.new, :merge)

    if constructor.present?
      constructor.where(id: mapping.keys).order(title: :asc).each do |item|
        yield item, (mapping[item.id] || 0)
      end
    else
      mapping.to_a.sort_by { |r| r[0] }.reverse.each do |title, value|
        yield title, value
      end
    end
  end

  def has_filters?(*fields)
    (params.keys & fields.map(&:to_s)).any?
  end

  def current_filters(**mapping)
    mapping.map do |filter_param, model|
      filter_ids = params[filter_param].to_s.split(',').map(&:to_i)

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
          if filter_ids.one?
            [[OpenStruct.new(label: filter_ids.first), replace_query_params(filter_param => nil), filter_param, params[filter_param]]]
          else
            filter_ids.map do |result|
              [OpenStruct.new(label: result), replace_query_params(filter_param => filter_ids - [result]), filter_param, params[filter_param]]
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
