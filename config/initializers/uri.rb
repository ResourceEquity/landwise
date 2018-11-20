require 'open3'

class URI::Generic

  def repair(**options)
    self.host   ||= (options[:host]   || Rails.application.config.action_controller.asset_host)
    self.scheme ||= (options[:scheme] || 'http')
    self
  end

  def route
    return [[empty_point], '', ''] if self.host.blank?

    repair

    # Create a tmp file to store any cookies and make the request
    tmp = Tempfile.new([Digest::SHA1.hexdigest(self.to_s), '.cookie'], Rails.root.join('tmp'))
    stdout, stderr, status = Open3.capture3("curl -sSL -c #{tmp.path} -H 'upgrade-insecure-requests: 1' -H 'user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36' -H 'accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8' -H 'accept-encoding: gzip, deflate, br' -H 'accept-language: en-US,en;q=0.9' -D - -o /dev/null #{self.to_s.gsub("'", "\\\\'")}")
    tmp.unlink

    points = stdout.strip.split("\r\n\r\n").map do |location|
      response = location.match(/(?<code>[0-9]{3})\s+(?<status>[A-Za-z\s]+)$/) || { 'code' => 601 }
      point    = location.scan(/(^[A-Za-z\-]+):\s*(.*$)/).to_h
                         .transform_keys{ |key| key.downcase }
                         .transform_values { |value| value.to_s.strip }

      { code: response[:code].to_i, status: response[:status].to_s.strip, location: URI.parse(point['location'] || self.to_s) }
    end

    return [[empty_point], stdout, stderr] if points.empty?

    [
      points.map do |point|
        OpenStruct.new(
          location: point[:location].repair(host: points.first[:location].host, scheme: points.first[:location].scheme),
          code: point[:code],
          status: point[:status]
        )
      end,
      stdout,
      stderr
    ]
  end

  def empty_point
    OpenStruct.new(
      location: self,
      code: 601,
      status: ''
    )
  end

end