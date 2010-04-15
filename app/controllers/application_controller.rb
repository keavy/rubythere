# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include Twitter::AuthenticationHelpers
  
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  filter_parameter_logging :password, :password_confirmation
  
  rescue_from Twitter::Unauthorized, :with => :force_sign_in
  
  if ENV['RAILS_ENV']=='production'
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
