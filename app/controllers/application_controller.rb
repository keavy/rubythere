require 'twitter/authentication_helpers'

class ApplicationController < ActionController::Base
  include Twitter::AuthenticationHelpers
  protect_from_forgery
  rescue_from Twitter::Unauthorized, :with => :force_sign_in

  if Rails.env == 'production'
    rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
    rescue_from ActionController::RoutingError, :with => :record_not_found
  end

  private

  def oauth_consumer
    @oauth_consumer ||= OAuth::Consumer.new(APP_CONFIG[:twitter_key], APP_CONFIG[:twitter_secret], :site => 'http://api.twitter.com', :request_endpoint => 'http://api.twitter.com', :sign_in => true)
  end

  def client
    Twitter.configure do |config|
      config.consumer_key = APP_CONFIG[:twitter_key]
      config.consumer_secret = APP_CONFIG[:twitter_secret]
      config.oauth_token = session['access_token']
      config.oauth_token_secret = session['access_secret']
    end
    @client ||= Twitter::Client.new
  end
  helper_method :client

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
