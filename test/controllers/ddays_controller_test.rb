require 'test_helper'

class DdaysControllerTest < ActionDispatch::IntegrationTest
  setup do
    @dday = ddays(:one)
  end

  test "should get index" do
    get ddays_url
    assert_response :success
  end

  test "should get new" do
    get new_dday_url
    assert_response :success
  end

  test "should create dday" do
    assert_difference('Dday.count') do
      post ddays_url, params: { dday: { day: @dday.day, project_id: @dday.project_id, success: @dday.success, user_id: @dday.user_id } }
    end

    assert_redirected_to dday_url(Dday.last)
  end

  test "should show dday" do
    get dday_url(@dday)
    assert_response :success
  end

  test "should get edit" do
    get edit_dday_url(@dday)
    assert_response :success
  end

  test "should update dday" do
    patch dday_url(@dday), params: { dday: { day: @dday.day, project_id: @dday.project_id, success: @dday.success, user_id: @dday.user_id } }
    assert_redirected_to dday_url(@dday)
  end

  test "should destroy dday" do
    assert_difference('Dday.count', -1) do
      delete dday_url(@dday)
    end

    assert_redirected_to ddays_url
  end
end
