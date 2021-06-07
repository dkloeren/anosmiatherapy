class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  include SimpleDiscussion::ForumUser
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :smell_programs
  has_many :smell_entries, through: :smell_programs
  has_many :scents, through: :smell_programs
  has_one_attached :avatar

  after_commit :ini_programs, on: [ :create ]

  def name
    "#{first_name} #{last_name}"
  end

  private

  def ini_programs
    # creating empty programs with the 4 initial seeds
    Scent.all[0..3].each do |scent|
      SmellProgram.create!(user: self, scent: scent, status: 1)
    end

    Scent.all[4..6].each do |scent|
      SmellProgram.create!(user: self, scent: scent, status: 0)
    end
  end
end


