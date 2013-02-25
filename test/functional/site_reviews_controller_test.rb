require File.dirname(__FILE__) + '/../test_helper'

class SiteReviewsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:site_reviews)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_site_review
    assert_difference('SiteReview.count') do
      post :create, :site_review => { }
    end

    assert_redirected_to site_review_path(assigns(:site_review))
  end

  def test_should_show_site_review
    get :show, :id => site_reviews(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => site_reviews(:one).id
    assert_response :success
  end

  def test_should_update_site_review
    put :update, :id => site_reviews(:one).id, :site_review => { }
    assert_redirected_to site_review_path(assigns(:site_review))
  end

  def test_should_destroy_site_review
    assert_difference('SiteReview.count', -1) do
      delete :destroy, :id => site_reviews(:one).id
    end

    assert_redirected_to site_reviews_path
  end
end
