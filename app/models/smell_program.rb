class SmellProgram < ApplicationRecord
  belongs_to :scent
  belongs_to :user
  has_many :smell_entries, dependent: :destroy

  enum status: %i[pending ready pause completed backlog]

  validates :scent_id, :user_id, :status, presence: true
  validates :user_id, uniqueness: { scope: :scent_id, message: "Smell training for this scent already exists!" }

  def ts_block_width(total_width_px, margin = 1, n_blocks = nil )
    #ts => time series
    n_blocks = self.smell_entries.length unless n_blocks.present?
    if n_blocks < 5
      (total_width_px / 5.to_f - margin).floor
    elsif n_blocks < 25
      (total_width_px / n_blocks.to_f - margin).floor
    else
      (total_width_px / n_blocks.to_f).floor
    end
  end

  def new?
    smell_entries.all.present? ? false : true
  end

  def progress_percentage
    self.new? ? 0 : 100 * (smell_entries.last.strength_rating + smell_entries.last.accuracy_rating) / 10
  end

  def perfect?
    self.new? ? false : smell_entries.last.strength_rating + smell_entries.last.accuracy_rating == 10
  end

  def completed?
    self.new? ? false : smell_entries.last.strength_rating > 3 && smell_entries.last.accuracy_rating > 3
  end

  def complete!
    self.status = "complete"
    self.save
  end

  def halt!
    self.status = "pending"
    self.save
  end

  def wait!
    self.status = "pause"
    self.save
  end

  def ready!
    self.status = "ready"
    self.save
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

  def comments
  end

end
