class Classroom < ApplicationRecord
  has_many :sections, dependent: :destroy

  validates :number, presence: true, uniqueness: true
end
