class SmellProgramsController < ApplicationController
  before_action :set_smell_program, only: [:show]

  def show
    if params[:selection]
      @selection = params[:selection]
    else
      @selection = "category"
    end

    @scents = {}
    # options = ["Any category", "Category", "New category", "Same category", "Paused trainings"]
    options = ["any", "category", "new", "same", "paused"]
    options.each do |option|
      case option
      when "any"
        @scents[option] = current_user.new_scents_all
      when "new"
        @scents[option] = current_user.new_scents_new_category
      when "same"
        @scents[option] = current_user.new_scents_by_category(@smell_program.scent.category)
      when "paused"
        @scents[option] = current_user.pending_scents
      end
    end

    if params[:scent_id]
      training = SmellProgram.new(user: current_user, scent: Scent.find(params[:scent_id]))
      training.status = "ready"
      if training.save
        @smell_program.status = "pending"
        @smell_program.save
        redirect_to smell_program_path(training)
      else
        render :show
      end
    end
  end

  def index
    @smell_programs = SmellProgram.all.where(user: current_user)
    smell_programs_status
  end

  def new
  end

  def create
    @smell_program = SmellProgram.new(smell_program_params)
    @smell_program.user = current_user

    if params[:program_id]
      smell_program_before = SmellProgram.find(params[:program_id])
      smell_program_before.status = "backlog" unless smell_program_before.status == "completed"
      smell_program.save
      @smell_program.status = 'ready'
    else
      @smell_program.status = 'ready'
    end

    if @smell_program.save
      redirect_to dashboard_path
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
