class Scent < ApplicationRecord
  has_many :smell_programs
  has_one_attached :photo

  validates :name, presence: true
end
