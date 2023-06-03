require "application_system_test_case"

class TicketListsTest < ApplicationSystemTestCase
  setup do
    @ticket_list = ticket_lists(:one)
  end

  test "visiting the index" do
    visit ticket_lists_url
    assert_selector "h1", text: "Ticket lists"
  end

  test "should create ticket list" do
    visit ticket_lists_url
    click_on "New ticket list"

    fill_in "Ticket", with: @ticket_list.ticket_id
    fill_in "User", with: @ticket_list.user_id
    click_on "Create Ticket list"

    assert_text "Ticket list was successfully created"
    click_on "Back"
  end

  test "should update Ticket list" do
    visit ticket_list_url(@ticket_list)
    click_on "Edit this ticket list", match: :first

    fill_in "Ticket", with: @ticket_list.ticket_id
    fill_in "User", with: @ticket_list.user_id
    click_on "Update Ticket list"

    assert_text "Ticket list was successfully updated"
    click_on "Back"
  end

  test "should destroy Ticket list" do
    visit ticket_list_url(@ticket_list)
    click_on "Destroy this ticket list", match: :first

    assert_text "Ticket list was successfully destroyed"
  end
end
