class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :user_has_teams?, if: Proc.new { |p| p.current_user.present? }

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :slack_username, :password, :password_confirmation, :remember_me)}
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email, :password, :remember_me)}
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :slack_username, :password, :password_confirmation, :remember_me, :current_password)}
  end

  def user_has_teams?
    unless current_user.teams.present? || (params[:controller] == "teams" && (params[:action] == "new" || params[:action] == "create"))
      redirect_to new_team_path
    end
  end
end