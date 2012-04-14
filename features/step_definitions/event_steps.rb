Given /^I have an event called "([^\"]*)"$/ do |name|
  @event = FactoryGirl.create(:event, :name => name, :twitter => @user.screen_name)
  FactoryGirl.create(:happening, :event => @event)
end

When /^I view the event page for (.*)/ do |name|
  stub_get("http://search.twitter.com/search.json?q=#{CGI.escape(@event.twitter)}", 'search.json')
  visit path_to("the event page for #{name}")
end

Given /^there is an event called "([^\"]*)"$/ do |name|
  @event = FactoryGirl.create(:event, :name => name)
  FactoryGirl.create(:happening, :event => @event)
end

Given /^twitter has some search results for "([^\"]*)"$/ do |name|
  stub_get("http://search.twitter.com/search.json?q=#{CGI.escape(name)}", 'search.json')
end

Then /^I should have downloaded a file called "([^\"]*)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

