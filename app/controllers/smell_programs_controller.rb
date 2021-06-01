class SmellProgramsController < ApplicationController

  def index
    @smell_programs = SmellProgram.all
  end

  private

  def set_smell_program
    @smell_program = SmellProgram.find(params[:id])
  end
end
