class SmellEntriesController < ApplicationController
  before_action :set_program, only: %i[new create]
  before_action :set_next_program, only: %i[new create start]

  def countdown
    @navbar_title = "Training"
    @smell_program = SmellProgram.find(params[:smell_program_id])
  end

  def new
    @navbar_title = "Evaluation"
    @entry = SmellEntry.new
    @authenticity_token = form_authenticity_token

    # Dynamic button name
    is_last_training = current_user.smell_programs.active.length - 1 <= 0
    @link_name = is_last_training ? "Finish Training" : @next_program.scent.name.capitalize
  end

  def create
    @entry = SmellEntry.new(entry_params)
    @entry.smell_program = @smell_program

    if @entry.save
      @smell_program.wait!
      redirect_after_create
    else
      render :new
    end
  end

  private

  def entry_params
    params.require(:smell_entry).permit(:strength_rating, :accuracy_rating)
  end

  def set_program
    @smell_program = SmellProgram.find(params[:smell_program_id])
  end

  def set_next_program
    @next_program = current_user.smell_programs.active.first
  end

  def redirect_after_create
    # redirect to next smell_entries#new page or to dashboard
    set_next_program
    if @next_program.present?
      redirect_to countdown_smell_program_smell_entries_path(@next_program)
    else
      redirect_to dashboard_path
    end
  end
end
