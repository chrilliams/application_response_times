require 'test_helper'

class BusinessSystemsControllerTest < ActionController::TestCase
  setup do
    @business_system = business_systems(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:business_systems)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create business_system" do
    assert_difference('BusinessSystem.count') do
      post :create, business_system: { business_service_name: @business_system.business_service_name, current_sla_kpi: @business_system.current_sla_kpi, metric_id: @business_system.metric_id, target: @business_system.target }
    end

#    assert_response :success
    assert_redirected_to business_systems_path
  end

  test "should show business_system" do
    get :show, id: @business_system
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @business_system
    assert_response :success
  end

  test "should update business_system" do
    patch :update, id: @business_system, business_system: { business_service_name: @business_system.business_service_name, current_sla_kpi: @business_system.current_sla_kpi, metric_id: @business_system.metric_id, target: @business_system.target }
#    assert_redirected_to business_system_path(assigns(:business_system))
        assert_redirected_to business_systems_path

  end

  test "should destroy business_system" do
    assert_difference('BusinessSystem.count', -1) do
      delete :destroy, id: @business_system
    end

    assert_redirected_to business_systems_path
  end
end
