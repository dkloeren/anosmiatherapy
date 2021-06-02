class SmellEntriesController < ApplicationController
  def new
    @entry = SmellEntry.new
    @smell_program = SmellProgram.find(params["smell_program_id"])
    # raise
  end

  def create
    @entry = SmellEntry.new(entry_params)
    @entry.user = current_user

    if @entry.save
      redirect_to dashboard_path(@entry)
      # check redirect path later
    else
      render :new
    end
  end

  private

  def entry_params
    params.require(:smell_entry).permit(:strength_rating, :accuracy_rating)
  end
end
