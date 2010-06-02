Given /^I am signed in$/ do
  @user = Factory(:user, :screen_name => 'paratweets')
  stub_post('http://api.twitter.com/oauth/access_token', 'access_token')
  stub_get('http://api.twitter.com/1/account/verify_credentials.json', 'verify_credentials.json')
  visit path_to('the auth confirm page')
end

Given /^I am a visitor$/ do
  log_out!
end

def log_out
  get '/logout'
end

def log_out!
  log_out
  response.should redirect_to(login_path)
  follow_redirect!
end