class SubscribeLeadService
  def self.run(*args)
    new(*args).run
  end

  def initialize(lead, list)
    @lead = lead
    @list = list
  end

  def run
    subscription.tap(&:save!)
  end

  private

  attr_reader :lead, :list

  def subscription
    Subscription.find_or_initialize_by(lead_id: lead.id, list_id: list.id) do |subscription|
      subscription.status = SubscriptionStatus::PENDING
    end
  end
end
