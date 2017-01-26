require "test_helper"

class ListTest < ActiveSupport::TestCase
  test "checks for attachment presence" do
    list = lists(:newsletter)

    refute list.attachment?

    list.attachment = Tempfile.new("foo")

    assert list.attachment?
  end
end
