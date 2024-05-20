class TeacherSubject < ApplicationRecord
  DEFAULT_LEVEL = 5

  belongs_to :teacher
  belongs_to :subject
  has_many :sections

  validates :teacher, uniqueness: { scope: :subject }, if: :_not_marked_for_destruction?

  validates :level, presence: true
  before_validation :_default_values_on_create, on: :create

  delegate :name, to: :subject, prefix: true
  delegate :first_and_last_name, to: :teacher

  def display_name
    "#{subject_name}, #{first_and_last_name}"
  end

  private

  def _default_values_on_create
    self.level ||= DEFAULT_LEVEL
    # return value should be true or nil
    true
  end

  def _not_marked_for_destruction?
    # Rails validation does not work well when we update subject with
    # teacher_subjects_attributes when we mark_for_destruction
    subject.teacher_subjects.none?(&:_destroy)
  end
end
