class PageInfo

  attr_accessor :current_page, :total_pages, :total_results, :per_page, :next_page, :prev_page

  def initialize(**args)
    args.each { |k, v| instance_variable_set("@#{k}", v) }
  end

end
