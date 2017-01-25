require "test_helper"

class RegisterLeadServiceTest < ActiveSupport::TestCase
  test "creates lead when does not exists" do
    lead = assert_difference -> { Lead.count } do
      RegisterLeadService.run("Jane", "jane@doe.com")
    end

    assert_equal lead.name, "Jane"
    assert_equal lead.email, "jane@doe.com"
  end

  test "fetches lead when already exists" do
    john = leads(:john)

    lead = assert_no_difference -> { Lead.count } do
      RegisterLeadService.run("John", "john@doe.com")
    end

    assert_equal lead.name, john.name
    assert_equal lead.email, john.email
  end

  test "updates lead name when already exists" do
    john = leads(:john)

    lead = RegisterLeadService.run("João", "john@doe.com")

    assert_equal lead.name, "João"
    assert_equal lead.email, john.email
  end
end
