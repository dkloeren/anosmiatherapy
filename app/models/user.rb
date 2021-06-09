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

  private

  def ini_programs
    # creating empty programs with the 4 initial seeds
    Scent.all[0..3].each do |scent|
      SmellProgram.create!(user: self, scent: scent, status: 1)
    end
  end
end


