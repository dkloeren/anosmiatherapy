class SmellProgramsController < ApplicationController
  before_action :set_smell_program, only: [:show]

  def show
    smell_program_history
    same_category

    @smell_program_new = SmellProgram.new
  end

  def index
    @smell_programs = SmellProgram.all.where(user: current_user)
    smell_programs_status
  end

  def new
  end

  def create
    raise
    @smell_program = SmellProgram.new(smell_program_params)
    @smell_program.user = current_user
    @smell_program.status = 'pending'

    if @smell_program.save
      redirect_to dashboard(@smell_program)
    else
      render :show
    end
  end

  private

  def smell_program_params
    # with collection .. scent_id instead of scent
    params.require(:smell_program).permit(:scent_id)
  end

  def set_smell_program
    @smell_program = SmellProgram.find(params[:id])
  end

  def smell_program_history
    @smell_training_log = @smell_program.smell_entries.map do |smell_entry|
      {
        strength: smell_entry.strength_rating,
        accuracy: smell_entry.accuracy_rating,
        date: smell_entry.created_at
      }
    end
  end

  def same_category
    @category_scents = Scent.where(category: @smell_program.scent.category)
  end

  def smell_programs_status
    @smell_programs_overview = @smell_programs.map do |smell_program|
      {
        scent: smell_program.scent.name,
        category: smell_program.scent.category,
        strength: smell_program.smell_entries.last.strength_rating,
        accuracy: smell_program.smell_entries.last.accuracy_rating,
        date_start: smell_program.smell_entries.first.created_at,
        date_end: smell_program.smell_entries.last.created_at,
        status: smell_program.status
      }
    end
  end

end
