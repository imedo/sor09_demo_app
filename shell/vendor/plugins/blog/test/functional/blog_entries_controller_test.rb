require File.dirname(__FILE__) + '/../test_helper'

class BlogEntriesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:blog_entries)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_blog_entry
    assert_difference('BlogEntry.count') do
      post :create, :blog_entry => { }
    end

    assert_redirected_to blog_entry_path(assigns(:blog_entry))
  end

  def test_should_show_blog_entry
    get :show, :id => blog_entries(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => blog_entries(:one).id
    assert_response :success
  end

  def test_should_update_blog_entry
    put :update, :id => blog_entries(:one).id, :blog_entry => { }
    assert_redirected_to blog_entry_path(assigns(:blog_entry))
  end

  def test_should_destroy_blog_entry
    assert_difference('BlogEntry.count', -1) do
      delete :destroy, :id => blog_entries(:one).id
    end

    assert_redirected_to blog_entries_path
  end
end
