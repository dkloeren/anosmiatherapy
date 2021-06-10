class ApplicationController < ActionController::Base
  before_action :authenticate_user!, :navbar_title

  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    dashboard_path
  end

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :avatar])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :avatar])
  end

  def navbar_title
    key = "#{params[:controller]}\##{params[:action]}"
    username = user_signed_in? ? "#{current_user.first_name.humanize} #{current_user.last_name.humanize}" : "Profile"
    titles = {
      "pages#home" => "",
      "pages#dashboard" => "Anosmiatherapy",
      "pages#profile" => username,
      "devise/registrations#new" => "Sign Up",
      "devise/registrations#edit" => "Profile",
      "devise/sessions#new" => "Log in",
      "devise/sessions#edit" => "Log in",
      "smell_programs#show" => "Smell Training Log",
      "smell_programs#index" => "All Smell Trainings",
      "products#index" => "Anosmiatherapy",
      "products#show" => "Anosmiatherapy",
      "payments#new" => "Anosmiatherapy",
      "orders#index" => "Anosmiatherapy",
      "orders#show" => "Anosmiatherapy",
      "simple_discussion/forum_threads#index" => "Anosmiatherapy",
      "simple_discussion/forum_threads#new" => "Anosmiatherapy",
      "simple_discussion/forum_threads#show" => "Anosmiatherapy"
    }

    @navbar_title = titles[key]
  end

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end

end
