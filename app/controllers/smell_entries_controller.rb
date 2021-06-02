class SmellEntriesController < ApplicationController
  before_action :set_scent, only: [:show]
  before_action :set_program

  def instructions
    # 1. press start button
    # 2. 20s countdown is displayed for the user to do the training
    @scent_count = params[:scent_count].to_i + 1
    @program_id = params[:program_id]

  end


  def new
    # 1. Evaluating one scent's strength
    # 2. Evaluating one scent's accuracy
    remaining_programs
  end

  def create

    if true
      if
    else

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

  def remaining_programs
    programs_ids = params["remaining_program_ids"]
    @next_program_id = programs_ids[0]
    if programs_ids.length > 1
      @remaining_program_ids = programs_ids[1..]
    else
      @remaining_program_ids = 0
    end
  end
end
