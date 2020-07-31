class ExampleController < ApplicationController

  layout 'blank'

  def index
  end

  def example1
    @search = Record.search(include: [:category, :record_countries, :countries, :items, :responsibility_records, :responsibilities]) do
      fulltext 'mozambique'
    end
    render 'example/example1'
  end

  def example2
    @search = Record.search(include: [:category, :record_countries, :countries, :items, :responsibility_records, :responsibilities]) do
      fulltext params[:q] || 'mozambique'
    end
    render 'example/example2'
  end

  def example3
    @search = Record.search(include: [:category, :record_countries, :countries, :items, :responsibility_records, :responsibilities]) do
      fulltext 'mozambique'
    end
    render 'example/example3'
  end

end
