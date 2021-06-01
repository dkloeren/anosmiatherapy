class SmellProgram < ApplicationRecord
  belongs_to :scent
  belongs_to :user
  has_many :smell_entries, dependent: :destroy

  enum status: [:active, :completed]

  validates :scent_id, :user_id, :status, presence: true
  validates :user_id, uniqueness: { scope: :scent_id,
    message: "Smell training for this scent already exists!" }
end
