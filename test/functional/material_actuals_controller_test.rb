require 'test_helper'

class MaterialActualsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:material_actuals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create material_actual" do
    assert_difference('MaterialActual.count') do
      post :create, :material_actual => { }
    end

    assert_redirected_to material_actual_path(assigns(:material_actual))
  end

  test "should show material_actual" do
    get :show, :id => material_actuals(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => material_actuals(:one).to_param
    assert_response :success
  end

  test "should update material_actual" do
    put :update, :id => material_actuals(:one).to_param, :material_actual => { }
    assert_redirected_to material_actual_path(assigns(:material_actual))
  end

  test "should destroy material_actual" do
    assert_difference('MaterialActual.count', -1) do
      delete :destroy, :id => material_actuals(:one).to_param
    end

    assert_redirected_to material_actuals_path
  end
end
