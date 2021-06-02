class SmellProgramsController < ApplicationController

  def index
    @smell_programs = SmellProgram.all
  end

  def training_session
    @current_programs = SmellProgram.where(user: current_user).where(status: 0)
    @current_programs.each_with_index do |program|
      redirect_to instructions_path(scent_count: index, program_id: program.id)
    end
  end

  private

  def set_smell_program
    @smell_program = SmellProgram.find(params[:id])
  end
end
