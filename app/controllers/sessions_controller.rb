class SessionsController < ApplicationController
  def new
  end
  
  def create
    oauth.set_callback_url(confirm_session_url)
    
    session['rtoken']  = oauth.request_token.token
    session['rsecret'] = oauth.request_token.secret
    
    redirect_to oauth.request_token.authorize_url
  end
  
  def destroy
    reset_session
    redirect_to new_session_path
  end
  
  def confirm
    oauth.authorize_from_request(session['rtoken'], session['rsecret'], params[:oauth_verifier])
    session['rtoken']  = nil
    session['rsecret'] = nil
    
    profile = Twitter::Base.new(oauth).verify_credentials
    if profile
      user    = User.find_or_create_by_screen_name(profile.screen_name)
    
      user.update_attributes({
        :atoken  => oauth.access_token.token, 
        :asecret => oauth.access_token.secret,
      })
    
      sign_in(user)
      redirect_back_or root_path
    else
      redirect_back_or login_path
    end
  end
  
  private
    def oauth
      @oauth ||= Twitter::OAuth.new(APP_CONFIG[:twitter_key], APP_CONFIG[:twitter_secret], :sign_in => true)
    end
end
