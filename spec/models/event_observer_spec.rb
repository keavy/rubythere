require 'spec_helper'

describe EventObserver do
  describe ".after_create" do
    it "calls .deliver on new_event_notification object" do
      event    = FactoryGirl.create(:event)
      observer = EventObserver.instance

      mail_mock = mock()
      mail_mock.expects(:deliver)
      Mailer.expects(:new_event_notification).with(event).returns(mail_mock)

      observer.after_create(event)
    end
  end
end