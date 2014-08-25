require 'test_helper'

class HourliesControllerTest < ActionController::TestCase
  setup do
    @hourly = hourlies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hourlies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hourly" do
    assert_difference('Hourly.count') do
      post :create, hourly: { average: @hourly.average, hour: @hourly.hour, maximum: @hourly.maximum, minimum: @hourly.minimum }
    end

    assert_redirected_to hourly_path(assigns(:hourly))
  end

  test "should show hourly" do
    get :show, id: @hourly
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @hourly
    assert_response :success
  end

  test "should update hourly" do
    patch :update, id: @hourly, hourly: { average: @hourly.average, hour: @hourly.hour, maximum: @hourly.maximum, minimum: @hourly.minimum }
    assert_redirected_to hourly_path(assigns(:hourly))
  end

  test "should destroy hourly" do
    assert_difference('Hourly.count', -1) do
      delete :destroy, id: @hourly
    end

    assert_redirected_to hourlies_path
  end
end
