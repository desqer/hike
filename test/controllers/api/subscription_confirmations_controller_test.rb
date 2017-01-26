require "test_helper"

class API::SubscriptionConfirmationsControllerTest < ActionDispatch::IntegrationTest
  test "success" do
    subscription = subscriptions(:john_newsletter)

    get api_subscription_confirmation_url(subscription), params: {}

    assert_response :ok
  end

  test "success with attachment" do
    subscription = subscriptions(:john_ebook)

    get api_subscription_confirmation_url(subscription), params: { redirect_url: "http://example.com" }

    assert @response.header["Content-Disposition"] =~ %r{attachment}
    assert @response.body =~ %r{Something cool!}
    assert_response :ok
  end

  test "success with redirect_url without attachment" do
    subscription = subscriptions(:john_newsletter)

    get api_subscription_confirmation_url(subscription), params: { redirect_url: "http://example.com" }

    assert @response.location =~ %r{http://example.com}
    assert_response :redirect
  end
end
