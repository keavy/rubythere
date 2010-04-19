require 'test_helper'

class MailerTest < ActionMailer::TestCase
  include ActionController::UrlWriter
  default_url_options[:host] = 'www.rubythere.com'
  
  context "new event notification" do
    setup do
      @event    = Factory(:event)
      @response = Mailer.create_new_event_notification(@event)
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
  
  context "new user notification" do
    setup do
      @user     = Factory(:user)
      @response = Mailer.create_new_user_notification(@user)
    end

    should "set the email subject" do
      assert_equal '[RubyThere] New user registered', @response.subject
    end
    
    should "include the screen_name for the user in the body" do
      assert_match /#{@user.screen_name}/, @response.body
      puts 
    end
    
    should "set email to field to #{EMAIL_CONTACT}" do
      assert_equal EMAIL_CONTACT, @response.to[0]
    end
  end
  

end
