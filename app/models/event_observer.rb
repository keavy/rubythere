class EventObserver < ActiveRecord::Observer
  def after_create(event)
    Mailer.new_event_notification(event).deliver unless !event.submitter.present?
  end
end
