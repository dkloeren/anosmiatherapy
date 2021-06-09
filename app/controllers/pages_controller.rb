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

    # Replace active trainings
    if params[:replace_trainings]
      replace_scents
    end

    # Reset button
    reset_current_training_status if params[:reset]

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

  def replace_scents
    current_user.completed_candidates.each do |training|
      if replace_with_new_category?
        replace_new(training, @scent_candidates[0])
      elsif replace_with_same_category?(training)
        replace_new(training, @scent_candidates[0])
      elsif replace_with_same_category_pending?(training)
        replace_reactivate(training, @program_candidates[0])
      elsif replace_with_any_category?
        replace_new(training, @scent_candidates[0])
      elsif replace_with_any_category_pending?
        replace_reactivate(training, @program_candidates[0])
      end
    end
  end

  def replace_new(current_training, new_scent)
    SmellProgram.create!(user: current_user, scent: new_scent, status: "ready")
    current_training.completed!
  end

  def replace_reactivate(current_training, new_training)
    new_training.ready!
    current_training.completed!
  end

  def replace_with_same_category?(training)
    @scent_candidates = Scent.where(category: training.scent.category) - current_user.scents
    @scent_candidates.present?
  end

  def replace_with_same_category_pending?(training)
    @program_candidates = current_user.current.select { |program| program.scent.category == training.scent.category }
    @program_candidates.present?
  end

  def replace_with_new_category?
    categories = Scent.select(:category).group(:category).map(&:category)
    current_categories = current_user.current.map { |training| training.scent.category }
    category_candidates = categories - current_categories
    @scent_candidates = Scent.where(category: category_candidates.sample) - current_user.scents
    @scent_candidates.present?
  end

  def replace_with_any_category?
    @scent_candidates = Scent.all - current_user.scents
    @scent_candidates.present?
  end

  def replace_with_any_category_pending?
    @program_candidates = current_user.current.present?
    @program_candidates.present?
  end

  def reset_current_training_status
    current_user.current.each(&:ready!)
  end

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
