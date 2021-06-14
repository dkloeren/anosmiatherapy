class Scent < ApplicationRecord
  has_many :smell_programs
  has_one_attached :photo

  validates :name, presence: true
end

def self.categories
  #  ...
  # [ cat1 cat 2 ...] ... if predefined
  Scent.all.map(&:category).uniq!
end
