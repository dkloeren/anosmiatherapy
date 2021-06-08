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
    @smell_trainings = SmellProgram.where(user: current_user).includes(:scent)
    @active_trainings = find_active_trainings_programs

    # Replace active trainings
    if params[:replace_training_id]
      replace_scents
      @active_trainings = find_active_trainings_programs
    end

    # Reset button
    if params[:reset]
      reset_current_training_status
    end

    # Greetings
    @greeting = set_greeting
    # @next_program is the first program to be trainine when training starts
    @next_program = SmellProgram.where(user: current_user).find_by(status: "ready")
    # active trainings which can be set to complete
    @finished_trainings_ids = find_finished_training_programs
    # Completed Trainings
    @completed_trainings = SmellProgram.where(user: current_user).where(status: ["completed"])
  end

  def profile
  end

  def info
    @navbar_title = "Information"
  end

  private

  def find_active_trainings_programs
    if @smell_trainings
      @smell_trainings.where(status: ["pause", "ready"])
    else
      SmellProgram.where(user: current_user).where(status: ["pause", "ready"])
    end
  end

  def replace_scents
    params[:replace_training_id].each do |training_id|
      training = @smell_trainings.find(training_id)
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
    current_training.status = "completed"
    current_training.save
  end

  def replace_reactivate(current_training, new_training)
    new_training.status = "ready"
    new_training.save
    current_training.status = "completed"
    current_training.save
  end

  def replace_with_same_category?(training)
    user_scents = @smell_trainings.map { |training| training.scent }
    @scent_candidates = Scent.where(category: training.scent.category) - user_scents
    @scent_candidates.present?
  end

  def replace_with_same_category_pending?(training)
    @pending_programs = @smell_trainings.where(status: ["pending", "backlog"])
    @program_candidates = @pending_programs.select { |program| program.scent.category == training.scent.category }
    @program_candidates.present?
  end

  def replace_with_new_category?
    categories = Scent.select(:category).group(:category).map(&:category)
    current_categories = @active_trainings.map { |training| training.scent.category }
    category_candidates = categories - current_categories
    user_scents = @smell_trainings.map(&:scent)
    @scent_candidates = Scent.where(category: category_candidates.sample) - user_scents
    @scent_candidates.present?
  end

  def replace_with_any_category?
    user_scents = @smell_trainings.map(&:scent)
    @scent_candidates = Scent.all - user_scents
    @scent_candidates.present?
  end

  def replace_with_any_category_pending?
    @program_candidates = @smell_trainings.where(status: ["pending", "backlog"])
    @program_candidates.present?
  end

  def find_finished_training_programs
    finished_trainings = @active_trainings.select do |training|
      if training.smell_entries.last
        training.smell_entries.last.strength_rating > 3 && training.smell_entries.last.accuracy_rating > 3;
      else
        false
      end
    end
    finished_trainings.map { |training| training.id }
  end

  def reset_current_training_status
    @active_trainings.each do |program|
      program.status = "ready"
      program.save
    end
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
