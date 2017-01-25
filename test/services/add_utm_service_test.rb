require "test_helper"

class AddUTMServiceTest < ActiveSupport::TestCase
  test "returns nil if has no url" do
    url = AddUTMService.run("", source: "link", medium: "email", campaign: "ab_test")

    assert_nil url
  end

  test "adds utm params to url" do
    url = AddUTMService.run("http://example.com", source: "link", medium: "email", campaign: "ab_test")

    assert url =~ /utm_source=link/
    assert url =~ /utm_medium=email/
    assert url =~ /utm_campaign=ab_test/
  end
end
