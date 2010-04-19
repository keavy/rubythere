class Mailer < ActionMailer::Base
  include ActionController::UrlWriter
  
  default_url_options[:host] = 'www.rubythere.com'
  
  def new_event_notification(event)
    setup_email
    @body[:url]  = admin_event_url(event)
    @subject    += 'New event submitted'
    @body[:event] = event
  end
  
  def new_user_notification(user)
    setup_email
    @body[:user] = user
    @subject    += 'New user registered'
  end
    
  protected
  def setup_email(email = nil)
    @recipients   = "#{email||EMAIL_CONTACT}"
    @from         = "#{EMAIL_CONTACT}"
    @subject      = "[RubyThere] "
    @sent_on      = Time.now
  end
end
