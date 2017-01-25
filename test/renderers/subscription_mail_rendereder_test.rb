require "test_helper"

class SubscriptionMailRendererTest < ActiveSupport::TestCase
  test "renders template" do
    subscription = subscriptions(:john_newsletter)
    renderer = SubscriptionMailRenderer.new(subscription)

    assert_equal renderer.call, "Olá John, bem vindo à nossa lista de news!"
  end
end
