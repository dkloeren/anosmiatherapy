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

  after_commit :ini_programs, on: [ :create ]

  def name
    "#{first_name} #{last_name}"
  end

  def completed
    smell_programs.where(status: "completed")
  end

  def active
    smell_programs.where(status: "ready")
  end

  def halted
    smell_programs.where(status: ["backlog", "pending"])
  end

  def current
    smell_programs.where(status: ["pause","ready"])
  end

  def waiting
    smell_programs.where(status: "pause")
  end

  def completed_candidates
    current.select do |program|
      program.completed?
    end
  end

  def new_scents_by_category(category)
    Scent.where(category: category) - scents
  end

  def new_scents_new_category
    categories = Scent.all.map(&:category).uniq!
    current_categories = self.current.map { |program| program.scent.category }
    new_categories = categories - current_categories
    new_categories.map { |category| self.new_scents_by_category(category) }.flatten
  end

  def pending_scents
    self.halted.map(&:scent)
  end

  def new_scents_all
    Scent.all - scents
  end

  def current_proram_info
    smell_programs.map do |program|
      if program.smell_entries.present?
        {
          scent: program.scent.name,
          strength: program.smell_entries.last.strength_rating,
          accuracy: program.smell_entries.last.accuracy_rating,
          tries: program.smell_entries.length,
          status: program.status,
          date: program.smell_entries.last.created_at
        }
      else
        {
          scent: program.scent.name,
          strength: 0,
          accuracy: 0,
          tries: 0,
          status: program.status,
          date: program.created_at
        }
      end
    end
  end

  private

  def ini_programs
    # creating empty programs with the 4 initial seeds
    Scent.all[0..3].each do |scent|
      SmellProgram.create!(user: self, scent: scent, status: 1)
    end
  end
end


