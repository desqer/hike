require "test_helper"

class SubscribeLeadServiceTest < ActiveSupport::TestCase
  test "creates lead when does not exists" do
    john = leads(:john)
    prelaunch = lists(:prelaunch)

    subscription = assert_difference -> { Subscription.count } do
      SubscribeLeadService.run(john, prelaunch)
    end

    assert_equal subscription.lead_id, john.id
    assert_equal subscription.list_id, prelaunch.id
    assert_equal subscription.status, SubscriptionStatus::PENDING
  end

  test "fetches lead when already exists" do
    john = leads(:john)
    ebook = lists(:ebook)
    john_ebook = subscriptions(:john_ebook)

    subscription = assert_no_difference -> { Subscription.count } do
      SubscribeLeadService.run(john, ebook)
    end

    assert_equal subscription.lead_id, john_ebook.lead_id
    assert_equal subscription.list_id, john_ebook.list_id
    assert_equal subscription.status, john_ebook.status
  end
end
