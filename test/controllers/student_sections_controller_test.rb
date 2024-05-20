require 'test_helper'

class StudentSectionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get student_sections_index_url
    assert_response :success
  end

  test "should get create" do
    get student_sections_create_url
    assert_response :success
  end

  test "should get show" do
    get student_sections_show_url
    assert_response :success
  end

  test "should get destroy" do
    get student_sections_destroy_url
    assert_response :success
  end

end
