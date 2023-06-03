require "application_system_test_case"

class TicketsTest < ApplicationSystemTestCase
  setup do
    @ticket = tickets(:one)
  end

  test "visiting the index" do
    visit tickets_url
    assert_selector "h1", text: "Tickets"
  end

  test "should create ticket" do
    visit tickets_url
    click_on "New ticket"

    fill_in "Accept or reject solution", with: @ticket.accept_or_reject_solution
    fill_in "Creation date", with: @ticket.creation_date
    fill_in "Incident description", with: @ticket.incident_description
    fill_in "Limit time resolution", with: @ticket.limit_time_resolution
    fill_in "Limit time response", with: @ticket.limit_time_response
    fill_in "Priority", with: @ticket.priority
    fill_in "Resolution date", with: @ticket.resolution_date
    fill_in "Resolution key", with: @ticket.resolution_key
    fill_in "Response key", with: @ticket.response_key
    fill_in "Response to user", with: @ticket.response_to_user
    fill_in "Response to user date", with: @ticket.response_to_user_date
    fill_in "Star number", with: @ticket.star_number
    fill_in "State", with: @ticket.state
    fill_in "Title", with: @ticket.title
    click_on "Create Ticket"

    assert_text "Ticket was successfully created"
    click_on "Back"
  end

  test "should update Ticket" do
    visit ticket_url(@ticket)
    click_on "Edit this ticket", match: :first

    fill_in "Accept or reject solution", with: @ticket.accept_or_reject_solution
    fill_in "Creation date", with: @ticket.creation_date
    fill_in "Incident description", with: @ticket.incident_description
    fill_in "Limit time resolution", with: @ticket.limit_time_resolution
    fill_in "Limit time response", with: @ticket.limit_time_response
    fill_in "Priority", with: @ticket.priority
    fill_in "Resolution date", with: @ticket.resolution_date
    fill_in "Resolution key", with: @ticket.resolution_key
    fill_in "Response key", with: @ticket.response_key
    fill_in "Response to user", with: @ticket.response_to_user
    fill_in "Response to user date", with: @ticket.response_to_user_date
    fill_in "Star number", with: @ticket.star_number
    fill_in "State", with: @ticket.state
    fill_in "Title", with: @ticket.title
    click_on "Update Ticket"

    assert_text "Ticket was successfully updated"
    click_on "Back"
  end

  test "should destroy Ticket" do
    visit ticket_url(@ticket)
    click_on "Destroy this ticket", match: :first

    assert_text "Ticket was successfully destroyed"
  end
end
