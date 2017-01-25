class AddUTMService
  def self.run(*args)
    new(*args).run
  end

  attr_reader :url, :source, :medium, :campaign

  def initialize(url, source:, medium:, campaign:)
    @url = url
    @source = source
    @medium = medium
    @campaign = campaign
  end

  def run
    return nil if url.blank?

    uri do |query|
      add_params(query)
    end
  end

  private

  def uri
    uri = URI(url)
    uri.query = yield uri.query
    uri.to_s
  end

  def add_params(query)
    query = URI.decode_www_form String(query)

    query << ["utm_source", source]
    query << ["utm_medium", medium]
    query << ["utm_campaign", campaign]

    URI.encode_www_form query
  end
end
