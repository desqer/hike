require "test_helper"

class SubscriptionsControllerTest < ActionDispatch::IntegrationTest
  test "success" do
    list = lists(:ebook)
    post subscriptions_url, params: subscription_params(name: "John", email: "john@doe.com", list_id: list.id)

    assert JSON(@response.body)["data"]
    assert_response :ok
  end

  test "error" do
    list = lists(:ebook)
    post subscriptions_url, params: subscription_params(list_id: list.id)

    assert JSON(@response.body)["errors"]
    assert_response :unprocessable_entity
  end

  private

  def subscription_params(name: nil, email: nil, list_id: nil)
    { data: {name: name, email: email, list_id: list_id} }
  end
end
