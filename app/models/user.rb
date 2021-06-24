class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  include SimpleDiscussion::ForumUser
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :smell_programs
  has_many :smell_entries, through: :smell_programs
  has_many :scents, through: :smell_programs
  has_many :orders
  has_one_attached :avatar

  after_commit :ini_programs, on: [:create]

  def name
    "#{first_name} #{last_name}"
  end

  def replace_completed_programs
    # --------------------------------------------------------------------------
    # Currently trained programs (up to 4) with ratings of at least 4/5 for both
    # accuracy and strength will be replaced with new training programs.
    # For the priority for new scents see "new_scents" method
    # --------------------------------------------------------------------------
    smell_programs.current.each do |training|
      scent = next_scent(training)
      if training.completed?
        scent.present? ? replace_program(training, scent) : training.completed!
      end
    end
  end

  def remaining_scents
    Scent.all - scents
  end

  # def current_proram_info
  #   smell_programs.map do |program|
  #     if program.smell_entries.present?
  #       {
  #         scent: program.scent.name,
  #         strength: program.smell_entries.last.strength_rating,
  #         accuracy: program.smell_entries.last.accuracy_rating,
  #         tries: program.smell_entries.length,
  #         status: program.status,
  #         date: program.smell_entries.last.created_at
  #       }
  #     else
  #       {
  #         scent: program.scent.name,
  #         strength: 0,
  #         accuracy: 0,
  #         tries: 0,
  #         status: program.status,
  #         date: program.created_at
  #       }
  #     end
  #   end
  # end

  private

  # Create 4 empty programs when a new user is created
  def ini_programs
    Scent.all[0..3].each do |scent|
      SmellProgram.create!(user: self, scent: scent, status: 1)
    end
  end

  # ============================================================================
  #   Replace completed Trainings with New/Paused Trainings
  # ============================================================================

  # Find next scent according to priority
  def next_scent(completed_training)
    # -----------------------
    # returns: Scent instance
    # -----------------------
    priority = 0
    scent_candidates = []
    until scent_candidates.present? || priority == 6
      priority += 1
      scent_candidates = get_next_scent_candidates(priority, completed_training)
    end
    scent_candidates.present? ? scent_candidates.flatten[0] : false
  end

  # Get scent candidates for next training program based on current training programs
  def get_next_scent_candidates(priority, completed_training)
    # ------------------------------------------------------------------
    # priority          : Integer, option parameter
    # completed_training: Smell_Program instance which is being replaced
    #
    # Priority for automatic selection of new scents:
    #   1 - new scents in a different category
    #   2 - new scents in the same category
    #   3 - new scents in any category
    #   4 - paused scents in different category
    #   5 - paused scents in same category
    #   6 - paused scents in any category
    #
    # returns           : Array of Scent instances
    # ------------------------------------------------------------------
    case priority
    when 1 then inactive_scents_by_category(inactive_scent_categories)
    when 2 then inactive_scents_by_category(completed_training.scent.category)
    when 3 then Scent.all - scents
    when 4 then scents_by_category_and_status(inactive_scent_categories, "pending")
    when 5 then scents_by_category_and_status(completed_training.scent.category, "pending")
    when 6 then scents_by_category_and_status(Scent.categories, "pending")
    else []
    end
  end

  # Replace a completed scent training with a training of a given scent
  def replace_program(completed_training, next_scent)
    # ----------------------------------------------------
    # a) Replace completed training with a paused training
    # b) Replace completed training with a new training
    # ----------------------------------------------------
    # returns: Boolean
    # ----------------------------------------------------
    if smell_programs.where(scent: next_scent).present?
      # PAUSED TRAINING
      next_training = SmellProgram.find_by(scent: next_scent)
      next_training.ready!
      completed_training.completed!
    elsif SmellProgram.create!(user: self, scent: next_scent, status: "ready")
      # NEW TRAINING
      completed_training.completed!
    else
      false
    end
  end

  # ============================================================================
  #    User scents/program information
  # ============================================================================

  def scents_by_category_and_status(categories, status)
    # --------------------------------------------------------------------
    # Find user scents that matches a combination of categories and status
    # --------------------------------------------------------------------
    categories = [categories] if categories.instance_of?(String)
    status = [status] if status.instance_of?(String)
    smell_programs.includes(:scent)
                  .where(scent: { category: categories })
                  .where(status: status)
                  .all.map(&:scent)
  end

  def current_scent_categories
    smell_programs.current.map { |program| program.scent.category }
  end

  def inactive_scent_categories
    Scent.categories - current_scent_categories
  end

  def inactive_scents_by_category(categories)
    categories = [categories] if categories.instance_of?(String)
    categories.map { |category| Scent.where(category: category) - scents }.flatten
  end
end
