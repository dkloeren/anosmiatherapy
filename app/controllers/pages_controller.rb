class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :info]
  before_action :set_greeting, only: [:dashboard]
  before_action :set_next_program, only: [:dashboard]

  # Landing Page
  def home
  end

  # Starting Smell Training with 20 second countdown
  def countdown
  end

  def dashboard
    # Check user interactivity/buttonpresses
    current_user.replace_completed_programs if params[:replace_trainings]
    reset_current_training_status if params[:reset]

    #button size
    set_dashboard_button_width
  end

  def info
    @navbar_title = "Information"
  end

  private

  # Define Greeting depending on daytime
  def set_greeting
    hour = Time.new.hour
    if (4..10).to_a.include?(hour)
      @greeting = "Good morning"
    elsif (13..17).to_a.include?(hour)
      @greeting = "Good afternoon"
    elsif (18..22).to_a.include?(hour)
      @greeting = "Good evening"
    else
      @greeting = "Hello"
    end
  end
end

def set_next_program
  @next_program = current_user.smell_programs.active.first
end

def set_dashboard_button_width
  if current_user.smell_programs.current.sufficently_trained.present?
    @button_width_css_class = "half"
  else
    @button_width_css_class = "full"
  end
end

# Restart training regardless whether they have been just trained.
def reset_current_training_status
  current_user.smell_programs.waiting.each(&:ready!)
  set_next_program
  redirect_to countdown_smell_program_smell_entries_path(@next_program)
end
