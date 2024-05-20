require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  test 'validate username, first_name, last_name presence' do
    student = Student.create first_name: '', username: ''
    assert student.errors[:username].present?
    assert student.errors[:first_name].present?
    assert student.errors[:last_name].present?
  end

  test 'valid fixture' do
    assert_valid_fixture students
  end
end
