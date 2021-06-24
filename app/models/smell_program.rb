class SmellProgram < ApplicationRecord
  belongs_to :scent
  belongs_to :user
  has_many :smell_entries, dependent: :destroy

  enum status: %i[pending ready pause completed]

  validates :scent_id, :user_id, :status, presence: true
  validates :user_id, uniqueness: { scope: :scent_id, message: "Smell training for this scent already exists!" }

  scope :completed, -> { where(status: "completed") }
  scope :active, -> { where(status: "ready") }
  scope :halted, -> { where(status: ["backlog", "pending"]) }
  scope :current, -> { where(status: ["pause", "ready"]) }
  scope :waiting, -> { where(status: "pause") }
  scope :started, -> { where(status: ["pause", "ready", "completed"]) }
  scope :sufficently_trained, lambda {
    includes(:smell_entries)
      .where(smell_entries: { strength_rating: 4.., accuracy_rating: 4.. })
  }
  # scope :sufficently_trained, lambda {
  #   joins(:smell_entries)
  #     .where("smell_entries.strength_rating > ?", 3)
  #     .and(where("smell_entries.accuracy_rating > ?", 3))
  # }

  # =================
  # Training Progress
  # =================

  def new?
    !smell_entries.all.present?
  end

  def progress
    new? ? 0 : 100 * (smell_entries.last.strength_rating + smell_entries.last.accuracy_rating) / 10
  end

  def perfect?
    new? ? false : smell_entries.last.strength_rating + smell_entries.last.accuracy_rating == 10
  end

  def completed?
    new? ? false : smell_entries.last.strength_rating > 3 && smell_entries.last.accuracy_rating > 3
  end

  # ======================
  # Change Training Status
  # ======================

  def complete!
    update(status: "complete")
  end

  def halt!
    update(status: "pending")
  end

  def wait!
    update(status: "pause")
  end

  def ready!
    update(status: "ready")
  end

  def logs
    smell_entries.map do |entry|
      {
        strength: entry.strength_rating,
        accuracy: entry.accuracy_rating,
        date: entry.created_at
      }
    end
  end

  # =========================================================
  # Adaptive css block width for Progression css block graph
  # =========================================================

  def ts_block_width(total_width_px, margin = 1, n_blocks = nil)
    n_blocks = smell_entries.length unless n_blocks.present?
    if n_blocks < 5
      (total_width_px / 5.to_f - margin).floor
    elsif n_blocks < 25
      (total_width_px / n_blocks.to_f - margin).floor
    else
      (total_width_px / n_blocks.to_f).floor
    end
  end
end
