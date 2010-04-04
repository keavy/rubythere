require 'test_helper'

class EventMailerTest < ActionMailer::TestCase
  include ActionController::UrlWriter
  default_url_options[:host] = 'www.rubythere.com'
  
  context "new event notification" do
    setup do
      @event    = Factory(:event)
      @response = EventMailer.create_new_event_notification(@event)
    end

    should "set the email subject" do
      assert_equal '[RubyThere] New event submitted', @response.subject
    end
    
    should "include the admin url for the event in the body" do
      assert_match /#{admin_event_url(@event)}/, @response.body
      puts 
    end
    
    should "set email to field to #{EMAIL_CONTACT}" do
      assert_equal EMAIL_CONTACT, @response.to[0]
    end
  end
  

end
