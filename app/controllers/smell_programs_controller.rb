class SmellProgramsController < ApplicationController
  before_action :set_smell_program, only: [:show]

  # keep actions short .. < 10 lines for example .. actual line of code
  #  ... private functions
  def show
    @selection = params[:selection] || "category"

    @scents = scents_dropdown

    # format nicely
    if params[:scent_id].present?
      training = SmellProgram.new(user: current_user,
                                  scent: Scent.find(params[:scent_id]),
                                  status: "ready")
      if training.save
        @smell_program.update(status: "pending")
        redirect_to smell_program_path(training)
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

  def scents_dropdown
        # options = ["Any category", "Category", "New category", "Same category", "Paused trainings"]
    # ... Just define hash .. hardcode!!
    options = i%(any category new same paused)  # sybmols
    options.each do |option|
      case option
      when :any
        @scents[option] = current_user.new_scents_all
      when :new
        @scents[option] = current_user.inactive_scents
      when :same
        @scents[option] = Scent.where(category: @smell_program.scent.category) - current_user.scents
      when :paused
        @scents[option] = current_user.pending_scents
      end
    end
  end
end
