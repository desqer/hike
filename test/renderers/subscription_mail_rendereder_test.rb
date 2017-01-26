require "test_helper"

class SubscriptionMailRendererTest < ActiveSupport::TestCase
  test "renders template" do
    subscription = subscriptions(:john_newsletter)
    renderer = SubscriptionMailRenderer.new(subscription, "http://example.com")
    message = "Olá John! Clique em http://localhost:3000/api/subscription_confirmations/#{subscription.id}?redirect_url=http%3A%2F%2Fexample.com para confirmar."

    assert_equal renderer.call, message
  end
end
