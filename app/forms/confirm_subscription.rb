class ConfirmSubscription
  def initialize(params)
    @subscription_id = params[:id]
    @redirect_url = params[:redirect_url]
  end

  def save
    subscription.activate!
  end

  def success_redirect
    add_utm_params redirect_url if redirect_url.present?
  end

  private

  attr_reader :subscription_id, :redirect_url

  def subscription
    Subscription.find(subscription_id)
  end

  def add_utm_params(url)
    url = URI(url)

    query = URI.decode_www_form String(url.query)
    query << ["utm_source", "hike"]
    query << ["utm_medium", "confirmation"]
    query << ["utm_campaign", subscription.list_id]

    url.query = URI.encode_www_form query
    url.to_s
  end
end
