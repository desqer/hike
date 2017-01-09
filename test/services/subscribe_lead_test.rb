require "test_helper"

class SubscribeLeadTest < ActiveSupport::TestCase
  test "creates lead when does not exists" do
    john = leads(:john)
    newsletter = lists(:newsletter)

    subscription = assert_difference -> { Subscription.count } do
      SubscribeLead.run(john, newsletter)
    end

    assert_equal subscription.lead_id, john.id
    assert_equal subscription.list_id, newsletter.id
    assert_equal subscription.status, SubscriptionStatus::PENDING
  end

  test "fetches lead when already exists" do
    john = leads(:john)
    ebook = lists(:ebook)
    john_ebook = subscriptions(:john_ebook)

    subscription = assert_no_difference -> { Subscription.count } do
      SubscribeLead.run(john, ebook)
    end

    assert_equal subscription.lead_id, john_ebook.lead_id
    assert_equal subscription.list_id, john_ebook.list_id
    assert_equal subscription.status, john_ebook.status
  end
end
