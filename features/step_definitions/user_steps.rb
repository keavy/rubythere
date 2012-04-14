Given /^I am signed in$/ do
  @user = FactoryGirl.create(:user, :screen_name => 'paratweets')

  visit login_path
  stub_post('http://api.twitter.com/oauth/request_token', 'access_token')
  click_button "Sign in with Twitter"

  stub_post('http://api.twitter.com/oauth/access_token', 'access_token')
  stub_get('https://api.twitter.com/1/account/verify_credentials.json', 'verify_credentials.json')
  visit callback_path(:oauth_verifier => 'some_key')
end

Given /^I am a visitor$/ do
  visit "/logout"
end