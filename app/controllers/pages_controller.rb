class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    # if user_signed_in?
    #   redirect_to dashboard_path
    # end
  end

  def dashboard
    @greeting = set_greeting

    # 4 open smell training programs
    @active_trainings = SmellProgram.where(user: current_user).where(status: 0)
    @remaining_program_ids = []
    @active_trainings.each do |training|
      @remaining_program_ids << training.id
    end
  end

  def profile

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
