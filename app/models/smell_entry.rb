class SmellEntry < ApplicationRecord
  belongs_to :smell_program

  validates :strength_rating, :accuracy_rating, :smell_program_id, presence: true
  validates :strength_rating, :accuracy_rating, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5}
end
