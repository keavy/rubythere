class Mailer < ActionMailer::Base
  include Rails.application.routes.url_helpers

  default_url_options[:host] = 'www.rubythere.com'

  def new_event_notification(event)
    setup_email(event.submitter.email)
    @url     = edit_admin_event_url(event)
    @subject += 'New event submitted'
    @event   = event
  end

  def new_user_notification(user)
    setup_email
    @user = user
    @subject    += 'New user registered'
  end

  protected
  def setup_email(from = nil, email = nil)
    @recipients   = "#{email||EMAIL_CONTACT}"
    @from         = "#{from||EMAIL_CONTACT}"
    @subject      = "[RubyThere] "
    @sent_on      = Time.now
  end
end
