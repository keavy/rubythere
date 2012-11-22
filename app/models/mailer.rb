class Mailer < ActionMailer::Base
  include Rails.application.routes.url_helpers

  default_url_options[:host] = 'www.rubythere.com'
  default :from => EMAIL_CONTACT

  def new_event_notification(event)
    @url     = edit_admin_event_url(event.id)
    @event   = event

    mail(:to => ENV['EMAIL_USER'], :reply_to => event.submitter.email, :subject => 'New event submitted')
  end

  def new_user_notification(user)
    @user = user

    mail(:to => EMAIL_CONTACT, :subject => 'New user registration')
  end
end
