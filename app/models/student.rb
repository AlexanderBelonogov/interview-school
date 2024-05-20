class Student < ApplicationRecord
  has_many :student_sections, dependent: :destroy
  has_many :sections, through: :student_sections

  validates :username, :first_name, :last_name, presence: true
  validates_uniqueness_of :username

  def first_and_last_name
    "#{first_name} #{last_name}"
  end

  def display_name
    "#{first_and_last_name} (#{username})"
  end
end
