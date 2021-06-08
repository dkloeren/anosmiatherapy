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
end
