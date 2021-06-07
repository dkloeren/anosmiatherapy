class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :info]

  def home
    if user_signed_in?
      redirect_to dashboard_path
    end
  end

  def countdown
  end

  def dashboard
    @active_trainings = SmellProgram.where(user: current_user).where(status: ["pause", "ready"])

    # if params[replace_scent_id]
    #   params[replace_scent_id].each do

    # end

    finished_trainings = @active_trainings.select do |training|
      training.smell_entries.last.strength_rating + training.smell_entries.last.accuracy_rating >= 8;
    end
    @finished_trainings_ids = finished_trainings.map { |training| training.id }

    # Reset button
    if params[:reset]
      @active_trainings.each do |program|
        program.status = "ready"
        program.save
      end
    end

    # Greetings
    @greeting = set_greeting

    # @next_program is the first program to be trainine when training starts
    @next_program = SmellProgram.where(user: current_user).find_by(status: "ready")

    # Completed Trainings
    @completed_trainings = SmellProgram.where(user: current_user).where(status: ["completed"])
  end

  def profile
  end

  def info
    @navbar_title = "Information"
  end

  private

  def set_greeting
    hour = Time.new.hour
    if (4..10).to_a.include?(hour)
      "Good morning"
    elsif (13..17).to_a.include?(hour)
      "Good afternoon"
    elsif (18..22).to_a.include?(hour)
      "Good evening"
    else
      "Hello"
    end
  end

  def test
  end
end
