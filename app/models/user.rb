class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :smell_programs
  has_many :smell_entries, through: :smell_programs
  has_many :scents, through: :smell_programs
  has_one_attached :avatar
end
