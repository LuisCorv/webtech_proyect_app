require "test_helper"

class AssignTicketsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @assign_ticket = assign_tickets(:one)
  end

  test "should get index" do
    get assign_tickets_url
    assert_response :success
  end

  test "should get new" do
    get new_assign_ticket_url
    assert_response :success
  end

  test "should create assign_ticket" do
    assert_difference("AssignTicket.count") do
      post assign_tickets_url, params: { assign_ticket: { ticket_id: @assign_ticket.ticket_id, user_id: @assign_ticket.user_id } }
    end

    assert_redirected_to assign_ticket_url(AssignTicket.last)
  end

  test "should show assign_ticket" do
    get assign_ticket_url(@assign_ticket)
    assert_response :success
  end

  test "should get edit" do
    get edit_assign_ticket_url(@assign_ticket)
    assert_response :success
  end

  test "should update assign_ticket" do
    patch assign_ticket_url(@assign_ticket), params: { assign_ticket: { ticket_id: @assign_ticket.ticket_id, user_id: @assign_ticket.user_id } }
    assert_redirected_to assign_ticket_url(@assign_ticket)
  end

  test "should destroy assign_ticket" do
    assert_difference("AssignTicket.count", -1) do
      delete assign_ticket_url(@assign_ticket)
    end

    assert_redirected_to assign_tickets_url
  end
end
