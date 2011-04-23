class EventObserver < ActiveRecord::Observer
  def after_create(event)
    Mailer.new_event_notification(event).deliver unless event.admin_submitted || !event.submitter.present?
  end
end
