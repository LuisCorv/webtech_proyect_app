require "test_helper"

class TicketListsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ticket_list = ticket_lists(:one)
  end

  test "should get index" do
    get ticket_lists_url
    assert_response :success
  end

  test "should get new" do
    get new_ticket_list_url
    assert_response :success
  end

  test "should create ticket_list" do
    assert_difference("TicketList.count") do
      post ticket_lists_url, params: { ticket_list: { ticket_id: @ticket_list.ticket_id, user_id: @ticket_list.user_id } }
    end

    assert_redirected_to ticket_list_url(TicketList.last)
  end

  test "should show ticket_list" do
    get ticket_list_url(@ticket_list)
    assert_response :success
  end

  test "should get edit" do
    get edit_ticket_list_url(@ticket_list)
    assert_response :success
  end

  test "should update ticket_list" do
    patch ticket_list_url(@ticket_list), params: { ticket_list: { ticket_id: @ticket_list.ticket_id, user_id: @ticket_list.user_id } }
    assert_redirected_to ticket_list_url(@ticket_list)
  end

  test "should destroy ticket_list" do
    assert_difference("TicketList.count", -1) do
      delete ticket_list_url(@ticket_list)
    end

    assert_redirected_to ticket_lists_url
  end
end
