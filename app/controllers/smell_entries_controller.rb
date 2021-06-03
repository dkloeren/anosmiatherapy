class SmellEntriesController < ApplicationController
  before_action :set_program, only: [:new, :create]
  before_action :set_next_program, only: [:new, :create, :start]

  def start
    @smell_program = SmellProgram.find(params[:id])
    @navbar_title = "Training"
  end

  def new
    @entry = SmellEntry.new
    @authenticity_token = form_authenticity_token
    @navbar_title = "Evaluation"
    prepare_next_program
    if @next_program
      @link_name = "Next: #{@next_program.scent.name}"
      # undo forcast
    else
      @link_name = "Finish Training"
    end
    @smell_program.status = "ready"
    @smell_program.save
  end

  def create
    @entry = SmellEntry.new(entry_params)
    @entry.smell_program = @smell_program

    # save and get next program if available
    prepare_next_program

    # redirect to next program or go back to dashboard
    if @entry.save
      if @next_program.present?
        redirect_to start_smell_program_smell_entries_path(@next_program)
      else
        redirect_to dashboard_path
      end
    else
      render :new
    end
  end

  private

  def entry_params
    params.require(:smell_entry).permit(:strength_rating, :accuracy_rating)
  end

  def set_scent
    @scent = Scent.find(params[:smell_program_id])
  end

  def set_program
    @smell_program = SmellProgram.find(params[:smell_program_id])
  end

  def set_next_program
    @next_program = SmellProgram.where(user: current_user).find_by(status: "ready")
  end

  def prepare_next_program
    @smell_program.status = "pause"
    @smell_program.save
    set_next_program
  end
end
