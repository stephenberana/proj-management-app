require "application_system_test_case"

class RelatedFilesTest < ApplicationSystemTestCase
  setup do
    @related_file = related_files(:one)
  end

  test "visiting the index" do
    visit related_files_url
    assert_selector "h1", text: "Related Files"
  end

  test "creating a Related file" do
    visit related_files_url
    click_on "New Related File"

    fill_in "Name", with: @related_file.name
    fill_in "Task", with: @related_file.task_id
    click_on "Create Related file"

    assert_text "Related file was successfully created"
    click_on "Back"
  end

  test "updating a Related file" do
    visit related_files_url
    click_on "Edit", match: :first

    fill_in "Name", with: @related_file.name
    fill_in "Task", with: @related_file.task_id
    click_on "Update Related file"

    assert_text "Related file was successfully updated"
    click_on "Back"
  end

  test "destroying a Related file" do
    visit related_files_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Related file was successfully destroyed"
  end
end
