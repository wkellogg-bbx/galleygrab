require File.dirname(__FILE__) + '/../test_helper'

class MarketingsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:marketings)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_marketing
    assert_difference('Marketing.count') do
      post :create, :marketing => { }
    end

    assert_redirected_to marketing_path(assigns(:marketing))
  end

  def test_should_show_marketing
    get :show, :id => marketings(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => marketings(:one).id
    assert_response :success
  end

  def test_should_update_marketing
    put :update, :id => marketings(:one).id, :marketing => { }
    assert_redirected_to marketing_path(assigns(:marketing))
  end

  def test_should_destroy_marketing
    assert_difference('Marketing.count', -1) do
      delete :destroy, :id => marketings(:one).id
    end

    assert_redirected_to marketings_path
  end
end
