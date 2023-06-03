require "application_system_test_case"

class AssignTicketsTest < ApplicationSystemTestCase
  setup do
    @assign_ticket = assign_tickets(:one)
  end

  test "visiting the index" do
    visit assign_tickets_url
    assert_selector "h1", text: "Assign tickets"
  end

  test "should create assign ticket" do
    visit assign_tickets_url
    click_on "New assign ticket"

    fill_in "Ticket", with: @assign_ticket.ticket_id
    fill_in "User", with: @assign_ticket.user_id
    click_on "Create Assign ticket"

    assert_text "Assign ticket was successfully created"
    click_on "Back"
  end

  test "should update Assign ticket" do
    visit assign_ticket_url(@assign_ticket)
    click_on "Edit this assign ticket", match: :first

    fill_in "Ticket", with: @assign_ticket.ticket_id
    fill_in "User", with: @assign_ticket.user_id
    click_on "Update Assign ticket"

    assert_text "Assign ticket was successfully updated"
    click_on "Back"
  end

  test "should destroy Assign ticket" do
    visit assign_ticket_url(@assign_ticket)
    click_on "Destroy this assign ticket", match: :first

    assert_text "Assign ticket was successfully destroyed"
  end
end
