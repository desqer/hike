class SubscriptionMailRenderer
  attr_reader :subscription

  delegate :lead, :list, to: :subscription

  def initialize(subscription)
    @subscription = subscription
  end

  def call
    liquid_template.render "lead" => lead_values
  end

  private

  def lead_values
    lead.attributes.slice("name", "email")
  end

  def liquid_template
    Liquid::Template.parse list.email_template
  end
end
