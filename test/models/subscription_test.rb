require "test_helper"

class SubscriptionTest < ActiveSupport::TestCase
  test "activates subscription" do
    subscription = subscriptions(:john_newsletter)

    subscription.activate!

    assert_equal subscription.status, SubscriptionStatus::ACTIVE
  end

  test "deactivates subscription" do
    subscription = subscriptions(:john_ebook)

    subscription.deactivate!

    assert_equal subscription.status, SubscriptionStatus::CANCELED
  end
end
