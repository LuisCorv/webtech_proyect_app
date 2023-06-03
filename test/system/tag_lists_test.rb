require "application_system_test_case"

class TagListsTest < ApplicationSystemTestCase
  setup do
    @tag_list = tag_lists(:one)
  end

  test "visiting the index" do
    visit tag_lists_url
    assert_selector "h1", text: "Tag lists"
  end

  test "should create tag list" do
    visit tag_lists_url
    click_on "New tag list"

    fill_in "Ticket", with: @tag_list.ticket_id
    click_on "Create Tag list"

    assert_text "Tag list was successfully created"
    click_on "Back"
  end

  test "should update Tag list" do
    visit tag_list_url(@tag_list)
    click_on "Edit this tag list", match: :first

    fill_in "Ticket", with: @tag_list.ticket_id
    click_on "Update Tag list"

    assert_text "Tag list was successfully updated"
    click_on "Back"
  end

  test "should destroy Tag list" do
    visit tag_list_url(@tag_list)
    click_on "Destroy this tag list", match: :first

    assert_text "Tag list was successfully destroyed"
  end
end
