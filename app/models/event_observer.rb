class EventObserver < ActiveRecord::Observer
  def after_create(event)
    EventMailer.deliver_new_event_notification(event) unless event.admin_submitted
  end
end
