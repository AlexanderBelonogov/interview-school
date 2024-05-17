class Student < ApplicationRecord
  validates :username, :first_name, :last_name, presence: true
  validates_uniqueness_of :username
end