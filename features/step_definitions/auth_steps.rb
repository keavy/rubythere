Given /^I am signed in$/ do
  stub_post('http://api.twitter.com/oauth/access_token', 'access_token')
  stub_get('http://api.twitter.com/1/account/verify_credentials.json', 'verify_credentials.json')
  visit path_to('the auth confirm page')
end