require "test_helper"

class ConfirmSubscriptionFormTest < ActiveSupport::TestCase
  test "raises exception when subscription is not found" do
    form = ConfirmSubscriptionForm.new(id: "123")

    assert_raises(ActiveRecord::RecordNotFound) { form.save }
  end

  test "activates subscription" do
    subscription = subscriptions(:john_ebook)
    form = ConfirmSubscriptionForm.new(id: subscription.id)

    assert form.save
    assert_equal subscription.status, SubscriptionStatus::ACTIVE
  end

  test "does not provide attachment without file" do
    subscription = subscriptions(:john_newsletter)
    form = ConfirmSubscriptionForm.new(id: subscription.id, redirect_url: "http://example.com")

    assert_nil form.attachment
  end

  test "provides attachment with file" do
    subscription = subscriptions(:john_ebook)
    form = ConfirmSubscriptionForm.new(id: subscription.id, redirect_url: "http://example.com")

    assert form.attachment
  end

  test "does not generate success_redirect without redirect_url" do
    subscription = subscriptions(:john_ebook)
    form = ConfirmSubscriptionForm.new(id: subscription.id, redirect_url: "")

    assert_nil form.success_redirect
  end

  test "adds utm params to success_redirect" do
    subscription = subscriptions(:john_ebook)
    form = ConfirmSubscriptionForm.new(id: subscription.id, redirect_url: "http://example.com")

    assert form.success_redirect =~ %r{http://example.com}
    assert form.success_redirect =~ %r{utm_source}
    assert form.success_redirect =~ %r{utm_medium}
    assert form.success_redirect =~ %r{utm_campaign}
  end
end
