class SmellProgramsController < ApplicationController
  before_action :set_smell_program, only: [:show]

  def show
    smell_program_history
  end

  def index
    @smell_programs = SmellProgram.all
  end

  def new
  end

  def create
  end

  private

  def set_smell_program
    @smell_program = SmellProgram.find(params[:id])
  end

  def smell_program_history
    @history = @smell_program.smell_entries.map do |smell_entry|
      {
        strength: smell_entry.strength_rating,
        accuracy: smell_entry.accuracy_rating,
        date: smell_entry.created_at
      }
    end
  end

end
