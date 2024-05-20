class StudentSection < ApplicationRecord
  belongs_to :section
  belongs_to :student

  validates :section, uniqueness: { scope: :student }

  delegate :first_and_last_name, to: :student
  delegate :display_name, to: :student
  delegate :name, to: :section, prefix: true

  validate :overlap

  private

  def overlap
    existing_sections = student.sections.where(
      "start_at BETWEEN ? AND ? or end_at BETWEEN ? AND ?",
      section.start_at, section.end_at, section.start_at, section.end_at
    )
    existing_sections.each do |existing_section|
      if (existing_section.week_days.split(',') & section.week_days.split(',')).present?
        errors.add(:week_days, "You already have section: #{existing_section.teacher_subject.subject_name}")
        return
      end
    end
  end
end
