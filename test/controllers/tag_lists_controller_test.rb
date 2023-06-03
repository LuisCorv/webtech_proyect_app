require "test_helper"

class TagListsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tag_list = tag_lists(:one)
  end

  test "should get index" do
    get tag_lists_url
    assert_response :success
  end

  test "should get new" do
    get new_tag_list_url
    assert_response :success
  end

  test "should create tag_list" do
    assert_difference("TagList.count") do
      post tag_lists_url, params: { tag_list: { ticket_id: @tag_list.ticket_id } }
    end

    assert_redirected_to tag_list_url(TagList.last)
  end

  test "should show tag_list" do
    get tag_list_url(@tag_list)
    assert_response :success
  end

  test "should get edit" do
    get edit_tag_list_url(@tag_list)
    assert_response :success
  end

  test "should update tag_list" do
    patch tag_list_url(@tag_list), params: { tag_list: { ticket_id: @tag_list.ticket_id } }
    assert_redirected_to tag_list_url(@tag_list)
  end

  test "should destroy tag_list" do
    assert_difference("TagList.count", -1) do
      delete tag_list_url(@tag_list)
    end

    assert_redirected_to tag_lists_url
  end
end
