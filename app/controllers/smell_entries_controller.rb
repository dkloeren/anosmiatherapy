class SmellEntriesController < ApplicationController
  before_action :set_scent, only: [:show]
  before_action :set_program

  def start
    # 1. press start button
    # 2. 20s countdown is displayed for the user to do the training
  end


  def new
    # 1. Evaluating one scent's strength
    # 2. Evaluating one scent's accuracy
    @smell_program.status = "pause"
    @smell_program.save
    set_next_program
  end

  def create

    # update status of program
    @smell_program.status = "pause"
    @smell_program.save
    set_next_program
    if true
      if @next_program.present?
        redirect_to new_smell_program_smell_entry_path(@next_program)
      else
        redirect_to dashboard_path
      end
    else
      render :new
    end
  end

  def show
  end

  private

  def set_scent
    @scent = Scent.find(params[:smell_program_id])
  end

  def scent_params
    params.require(scent).permit(:strength_rating, :accuracy_rating)
  end

  def set_program
    @smell_program = SmellProgram.find(params[:smell_program_id])
  end

  def set_next_program
    @next_program = SmellProgram.where(user: current_user).find_by(status: "ready")

    # @next_program_id = programs_ids[0]
    # if programs_ids.length > 1
    #   @remaining_program_ids = programs_ids[1..]
    # else
    #   @remaining_program_ids = 0
    # end
  end
end
