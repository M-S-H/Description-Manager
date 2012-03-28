require 'test_helper'

class OntologicalDescriptionsControllerTest < ActionController::TestCase
  setup do
    @ontological_description = ontological_descriptions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ontological_descriptions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ontological_description" do
    assert_difference('OntologicalDescription.count') do
      post :create, ontological_description: @ontological_description.attributes
    end

    assert_redirected_to ontological_description_path(assigns(:ontological_description))
  end

  test "should show ontological_description" do
    get :show, id: @ontological_description
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ontological_description
    assert_response :success
  end

  test "should update ontological_description" do
    put :update, id: @ontological_description, ontological_description: @ontological_description.attributes
    assert_redirected_to ontological_description_path(assigns(:ontological_description))
  end

  test "should destroy ontological_description" do
    assert_difference('OntologicalDescription.count', -1) do
      delete :destroy, id: @ontological_description
    end

    assert_redirected_to ontological_descriptions_path
  end
end
