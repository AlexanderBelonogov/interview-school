require 'test_helper'

class ClassroomTest < ActiveSupport::TestCase
  test 'validate number presence' do
    classroom = Classroom.create number: ''
    assert classroom.errors[:number].present?
  end
  test 'valid fixture' do
    assert_valid_fixture classrooms
  end
end
