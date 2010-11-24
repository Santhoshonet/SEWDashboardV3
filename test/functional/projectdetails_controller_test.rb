require 'test_helper'

class ProjectdetailsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:projectdetails)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create projectdetail" do
    assert_difference('Projectdetail.count') do
      post :create, :projectdetail => { }
    end

    assert_redirected_to projectdetail_path(assigns(:projectdetail))
  end

  test "should show projectdetail" do
    get :show, :id => projectdetails(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => projectdetails(:one).to_param
    assert_response :success
  end

  test "should update projectdetail" do
    put :update, :id => projectdetails(:one).to_param, :projectdetail => { }
    assert_redirected_to projectdetail_path(assigns(:projectdetail))
  end

  test "should destroy projectdetail" do
    assert_difference('Projectdetail.count', -1) do
      delete :destroy, :id => projectdetails(:one).to_param
    end

    assert_redirected_to projectdetails_path
  end
end
