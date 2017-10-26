require 'test_helper'

class SiteControllerTest < ActionDispatch::IntegrationTest
  test "should get randing" do
    get site_randing_url
    assert_response :success
  end

end
