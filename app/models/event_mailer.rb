class EventMailer < ActionMailer::Base
  include ActionController::UrlWriter
  
  default_url_options[:host] = 'www.rubythere.com'
  
  def new_event_notification(event)
    setup_email(event, @recipients)
    @body[:url]  = admin_event_url(event)
    @subject    += 'New event submitted'
  end
    
  protected
  def setup_email(event, email = nil)
    @recipients   = "#{email||EMAIL_CONTACT}"
    @from         = "#{EMAIL_CONTACT}"
    @subject      = "[RubyThere] "
    @sent_on      = Time.now
    @body[:event] = event
  end
end
