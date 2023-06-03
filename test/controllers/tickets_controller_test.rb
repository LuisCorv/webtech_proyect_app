require "test_helper"

class TicketsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ticket = tickets(:one)
  end

  test "should get index" do
    get tickets_url
    assert_response :success
  end

  test "should get new" do
    get new_ticket_url
    assert_response :success
  end

  test "should create ticket" do
    assert_difference("Ticket.count") do
      post tickets_url, params: { ticket: { accept_or_reject_solution: @ticket.accept_or_reject_solution, creation_date: @ticket.creation_date, incident_description: @ticket.incident_description, limit_time_resolution: @ticket.limit_time_resolution, limit_time_response: @ticket.limit_time_response, priority: @ticket.priority, resolution_date: @ticket.resolution_date, resolution_key: @ticket.resolution_key, response_key: @ticket.response_key, response_to_user: @ticket.response_to_user, response_to_user_date: @ticket.response_to_user_date, star_number: @ticket.star_number, state: @ticket.state, title: @ticket.title } }
    end

    assert_redirected_to ticket_url(Ticket.last)
  end

  test "should show ticket" do
    get ticket_url(@ticket)
    assert_response :success
  end

  test "should get edit" do
    get edit_ticket_url(@ticket)
    assert_response :success
  end

  test "should update ticket" do
    patch ticket_url(@ticket), params: { ticket: { accept_or_reject_solution: @ticket.accept_or_reject_solution, creation_date: @ticket.creation_date, incident_description: @ticket.incident_description, limit_time_resolution: @ticket.limit_time_resolution, limit_time_response: @ticket.limit_time_response, priority: @ticket.priority, resolution_date: @ticket.resolution_date, resolution_key: @ticket.resolution_key, response_key: @ticket.response_key, response_to_user: @ticket.response_to_user, response_to_user_date: @ticket.response_to_user_date, star_number: @ticket.star_number, state: @ticket.state, title: @ticket.title } }
    assert_redirected_to ticket_url(@ticket)
  end

  test "should destroy ticket" do
    assert_difference("Ticket.count", -1) do
      delete ticket_url(@ticket)
    end

    assert_redirected_to tickets_url
  end
end
