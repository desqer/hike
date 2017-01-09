require "test_helper"

class CreateSubscriptionTest < ActiveSupport::TestCase
  test "raises exception when list is not found" do
    form = CreateSubscription.new(name: "John", email: "john@doe.com", list_id: nil)
    assert_raises(ActiveRecord::RecordNotFound) { form.save }
  end

  test "does not save when name is empty" do
    list = lists(:ebook)
    form = CreateSubscription.new(name: "", email: "john@doe.com", list_id: list.id)

    refute form.save
    assert form.error_messages.include?("Name can't be blank")
  end

  test "does not save when email is empty" do
    list = lists(:ebook)
    form = CreateSubscription.new(name: "John", email: "", list_id: list.id)

    refute form.save
    assert form.error_messages.include?("Email can't be blank")
  end

  test "does not save when email is invalid" do
    list = lists(:ebook)
    form = CreateSubscription.new(name: "John", email: "johndoe.com", list_id: list.id)

    refute form.save
    assert form.error_messages.include?("Email is invalid")
  end

  test "save" do
    list = lists(:ebook)
    form = CreateSubscription.new(name: "John", email: "john@doe.com", list_id: list.id)

    assert form.save
    assert_equal form.data, { name: "John", email: "john@doe.com" }
  end
end
