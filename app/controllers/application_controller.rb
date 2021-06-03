class ApplicationController < ActionController::Base
  before_action :authenticate_user!, :navbar_title

  before_action :configure_permitted_parameters, if: :devise_controller?

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
      "smell_programs#index" => "Smell Programs"
    }
    @navbar_title = titles[key]
  end
end
