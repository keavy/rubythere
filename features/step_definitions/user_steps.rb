Given /^(?:|I )(is|am) a visitor$/ do |person|
  log_out!
end

def log_out
  get '/logout'
end

def log_out!
  log_out
  response.should redirect_to(new_session_path)
  follow_redirect!
end