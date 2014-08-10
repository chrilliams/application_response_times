require 'test_helper'

class RefDataControllerTest < ActionController::TestCase
  setup do
    @ref_datum = ref_data(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ref_data)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ref_datum" do
    assert_difference('RefDatum.count') do
      post :create, ref_datum: { code: @ref_datum.code, description: @ref_datum.description }
    end

    assert_redirected_to ref_datum_path(assigns(:ref_datum))
  end

  test "should show ref_datum" do
    get :show, id: @ref_datum
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ref_datum
    assert_response :success
  end

  test "should update ref_datum" do
    patch :update, id: @ref_datum, ref_datum: { code: @ref_datum.code, description: @ref_datum.description }
    assert_redirected_to ref_datum_path(assigns(:ref_datum))
  end

  test "should destroy ref_datum" do
    assert_difference('RefDatum.count', -1) do
      delete :destroy, id: @ref_datum
    end

    assert_redirected_to ref_data_path
  end
end
