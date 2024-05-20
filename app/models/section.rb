class Section < ApplicationRecord
  TIME = {
    start_time: 27000, # 7:30 AM
    end_time: 79200 # 10:00 PM
  }
  DAYS = {
    mwf: "Mon,Wed,Fri",
    all: "Mon,Tue,Wed,Thu,Fri",
    tth: "Tue,Th"
  }
  DURATION = {
    50 => 3000,
    80 => 4800,
  }

  belongs_to :teacher_subject
  belongs_to :classroom

  has_many :student_sections, dependent: :destroy
  has_many :students, through: :student_sections

  before_validation :_set_values

  validates :teacher_subject, :classroom, :start_at, :end_at, :duration, presence: true

  validates :start_at, numericality: { greater_than_or_equal_to: TIME[:start_time], message: "Must be after 7:30 AM" }
  validates :end_at, numericality: { less_than_or_equal_to: TIME[:end_time], greater_than: :start_at,  message: "Must be before 10:00 PM and be after start at" }

  validates :duration, inclusion: { in: DURATION.values, message: "Wrong duration" }
  validates :week_days, inclusion: { in: DAYS.values, message: "Wrong working days" }

  validate :section_classroom, :section_teacher_subject

  delegate :count, to: :students, prefix: true
  delegate :number, to: :classroom, prefix: true

  def start_at_to_am_pm
    start_at.to_am_pm
  end

  def end_at_to_am_pm
    end_at.to_am_pm
  end

  private

  #TODO
  def section_classroom
    true
  end

  #TODO
  def section_teacher_subject
    true
  end

  def _set_values
    self.end_at = self.start_at + self.duration
    self.week_days = DAYS[self.week_days.to_sym]
  end
end
