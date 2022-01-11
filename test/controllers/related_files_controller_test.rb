require "test_helper"

class RelatedFilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @related_file = related_files(:one)
  end

  test "should get index" do
    get related_files_url
    assert_response :success
  end

  test "should get new" do
    get new_related_file_url
    assert_response :success
  end

  test "should create related_file" do
    assert_difference('RelatedFile.count') do
      post related_files_url, params: { related_file: { name: @related_file.name, task_id: @related_file.task_id } }
    end

    assert_redirected_to related_file_url(RelatedFile.last)
  end

  test "should show related_file" do
    get related_file_url(@related_file)
    assert_response :success
  end

  test "should get edit" do
    get edit_related_file_url(@related_file)
    assert_response :success
  end

  test "should update related_file" do
    patch related_file_url(@related_file), params: { related_file: { name: @related_file.name, task_id: @related_file.task_id } }
    assert_redirected_to related_file_url(@related_file)
  end

  test "should destroy related_file" do
    assert_difference('RelatedFile.count', -1) do
      delete related_file_url(@related_file)
    end

    assert_redirected_to related_files_url
  end
end
