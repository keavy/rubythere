require 'spec_helper'

describe EventObserver do
  describe ".after_create" do
    it "calls .deliver on new_event_notification object" do
      event    = Factory(:event)
      observer = EventObserver.instance

      mail_mock = mock()
      mail_mock.should_receive(:deliver)
      Mailer.should_receive(:new_event_notification).with(event).and_return(mail_mock)

      observer.after_create(event)
    end
  end
end