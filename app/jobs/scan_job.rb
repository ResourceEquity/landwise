class ScanJob < ApplicationJob

  queue_as :low

  rescue_from ActiveJob::DeserializationError do |error|
  end

  def perform(instance)
    # Only allow attributes that actually exist on the model
    fields = instance.class::LINK_FIELDS.map(&:to_s) & instance.class.columns.map(&:name)

    fields.each do |attribute|
      value = instance.send(attribute)

      links = URI.extract(value.to_s, ['http', 'https', 'ftp'])

      links.each do |link|
        route, stdout, stderr = URI.parse(link).route

        if route.first.code == 301 && route.last.code == 200
          instance.update(attribute => value.gsub(link, route.last.location.to_s))
        end

        if route.last.code.between?(200, 299)
          record = instance.links.find_by(url: link)
          record.destroy if record.present?
        else
          record = instance.links.find_or_create_by(url: link)
          record.update(code: route.last.code, stdout: stdout, stderr: stderr)
        end
      end
    end

    instance.scan(1.week)
  end

end