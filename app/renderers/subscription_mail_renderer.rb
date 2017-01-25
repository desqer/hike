class SubscriptionMailRenderer
  include Rails.application.routes.url_helpers

  attr_reader :subscription

  delegate :lead, :list, to: :subscription

  def initialize(subscription)
    @subscription = subscription
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
    { "confirmation_link" => api_subscription_confirmation_url(subscription) }
  end

  def liquid_template
    Liquid::Template.parse list.email_template
  end
end
