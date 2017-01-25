require "test_helper"

class CreateSubscriptionFormTest < ActiveSupport::TestCase
  test "raises exception when list is not found" do
    form = CreateSubscriptionForm.new(name: "John", email: "john@doe.com", list_id: "123")
    assert_raises(ActiveRecord::RecordNotFound) { form.save }
  end

  test "does not save when list_id is empty" do
    list = lists(:ebook)
    form = CreateSubscriptionForm.new(email: "john@doe.com", list_id: "")

    refute form.save
    assert form.error_messages.include?("List can't be blank")
  end

  test "does not save when email is empty" do
    list = lists(:ebook)
    form = CreateSubscriptionForm.new(name: "John", email: "", list_id: list.id)

    refute form.save
    assert form.error_messages.include?("Email can't be blank")
  end

  test "does not save when email is invalid" do
    list = lists(:ebook)
    form = CreateSubscriptionForm.new(name: "John", email: "johndoe.com", list_id: list.id)

    refute form.save
    assert form.error_messages.include?("Email is invalid")
  end

  test "save" do
    list = lists(:ebook)
    form = CreateSubscriptionForm.new(name: "John", email: "john@doe.com", list_id: list.id)

    assert form.save
    assert_equal form.data, { email: "john@doe.com", list_id: list.id }
  end

  test "does not generate success_redirect without redirect_url" do
    form = CreateSubscriptionForm.new(redirect_url: "")

    assert_nil form.success_redirect
  end

  test "adds utm params to success_redirect" do
    form = CreateSubscriptionForm.new(redirect_url: "http://example.com")

    assert form.success_redirect =~ %r{http://example.com}
    assert form.success_redirect =~ %r{utm_source}
    assert form.success_redirect =~ %r{utm_medium}
    assert form.success_redirect =~ %r{utm_campaign}
  end
end
