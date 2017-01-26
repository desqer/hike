class SubscriptionMailRenderer
  include Rails.application.routes.url_helpers

  attr_reader :subscription, :redirect_url

  delegate :lead, :list, to: :subscription

  def initialize(subscription, redirect_url)
    @subscription = subscription
    @redirect_url = redirect_url
  end

  def call
    liquid_template.render(
      "lead" => lead_values,
      "subscription" => subscription_values
    )
  end

  private

  def lead_values
    lead.attributes.slice("name", "email")
  end

  def subscription_values
    { "confirmation_link" => api_subscription_confirmation_url(subscription, redirect_url: redirect_url) }
  end

  def liquid_template
    Liquid::Template.parse list.email_template
  end
end
