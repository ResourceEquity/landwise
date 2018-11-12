module RecordsHelper

  def has_facet?(facet)
    @search.facet(facet).rows.any?
  end

  def has_query?
    search_query.present?
  end

  def search_query
    params[:q].to_s.strip
  end

  def per_page_link(count)
    per_page = (params[:per] || 25).to_i

    if per_page == count
      content_tag :em, count
    else
      link_to count, replace_query_params(per: count)
    end
  end

  def sort_links(fields, options={})
    options[:default] ||= :relevancy
    sort_by = params[:sort] || options[:default]

    fields.map do |field, label|
      if sort_by.to_sym == field.to_sym
        content_tag(:em, label)
      else
        link_to(label, replace_query_params(sort: field))
      end
    end.join('').html_safe
  end

  def replace_query_params(**query_params)
    url = request.base_url + request.original_fullpath
    uri = URI.parse(url)

    query = Rack::Utils.parse_query(uri.query)
    query_params.each do |key, value|
      if value.nil?
        query.delete(key.to_s)
      else
        query[key.to_s] = value
      end
    end

    uri.query = Rack::Utils.build_query(query)
    uri.to_s
  end

end
