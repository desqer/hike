class ConfirmSubscriptionForm
  attr_reader :subscription_id, :redirect_url

  def initialize(params)
    @subscription_id = params[:id]
    @redirect_url = params[:redirect_url]
  end

  def save
    subscription.activate!
  end

  def success_redirect
    AddUTMService.run(redirect_url, source: "hike", medium: "confirmation", campaign: subscription.list_id)
  end

  def attachment
    subscription.list_attachment_path if subscription.list_attachment?
  end

  private

  def subscription
    @subscription ||= Subscription.find(subscription_id)
  end
end
