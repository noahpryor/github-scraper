require 'test_helper'

class GemfilesControllerTest < ActionController::TestCase
  setup do
    @gemfile = gemfiles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:gemfiles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create gemfile" do
    assert_difference('Gemfile.count') do
      post :create, gemfile: { contents: @gemfile.contents, last_checked: @gemfile.last_checked, repository_id: @gemfile.repository_id, url: @gemfile.url }
    end

    assert_redirected_to gemfile_path(assigns(:gemfile))
  end

  test "should show gemfile" do
    get :show, id: @gemfile
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @gemfile
    assert_response :success
  end

  test "should update gemfile" do
    patch :update, id: @gemfile, gemfile: { contents: @gemfile.contents, last_checked: @gemfile.last_checked, repository_id: @gemfile.repository_id, url: @gemfile.url }
    assert_redirected_to gemfile_path(assigns(:gemfile))
  end

  test "should destroy gemfile" do
    assert_difference('Gemfile.count', -1) do
      delete :destroy, id: @gemfile
    end

    assert_redirected_to gemfiles_path
  end
end
