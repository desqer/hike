require "test_helper"

class ConfirmSubscriptionTest < ActiveSupport::TestCase
  test "raises exception when subscription is not found" do
    form = ConfirmSubscription.new(id: "123")

    assert_raises(ActiveRecord::RecordNotFound) { form.save }
  end

  test "activates subscription" do
    subscription = subscriptions(:john_ebook)
    form = ConfirmSubscription.new(id: subscription.id)

    assert form.save
    assert_equal subscription.status, SubscriptionStatus::ACTIVE
  end

  test "does not generate success_redirect without redirect_url" do
    subscription = subscriptions(:john_ebook)
    form = ConfirmSubscription.new(id: subscription.id, redirect_url: "")

    assert_nil form.success_redirect
  end

  test "adds utm params to success_redirect" do
    subscription = subscriptions(:john_ebook)
    form = ConfirmSubscription.new(id: subscription.id, redirect_url: "http://example.com")

    assert form.success_redirect =~ %r{http://example.com}
    assert form.success_redirect =~ %r{utm_source}
    assert form.success_redirect =~ %r{utm_medium}
    assert form.success_redirect =~ %r{utm_campaign}
  end
end
