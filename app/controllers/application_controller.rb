class ApplicationController < ActionController::Base
  protect_from_forgery

  include Twitter::AuthenticationHelpers
  rescue_from Twitter::Unauthorized, :with => :force_sign_in

  if Rails.env == 'production'
    rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
    rescue_from ActionController::RoutingError, :with => :record_not_found
  end

  private
  def force_sign_in(exception)
    reset_session
    flash[:error] = 'Seems your credentials are not good anymore. Please sign in again.'
    redirect_to new_session_path
  end

  def record_not_found
    flash[:error] = 'Sorry, the page you requested was not found.' if flash.empty?
    if signed_in?
      redirect_to account_url
    else
      redirect_to root_url
    end
  end
end
