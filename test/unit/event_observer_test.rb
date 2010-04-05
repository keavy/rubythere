require 'test_helper'

class EventObserverTest < ActiveSupport::TestCase
  def setup
    ActionMailer::Base.delivery_method    = :test
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries         = []
    @emails                               = ActionMailer::Base.deliveries
    @event_observer                       = EventObserver.instance
  end
  
  context "a new event is created from public side" do
    setup do
      @event = Factory(:event)
    end

    should "send out notification email after creation" do
      @emails.clear
      @event_observer.after_create(@event)
      assert_equal 1, @emails.size
    end
  end
  
  context "a new event is created from admin side" do
    setup do
      @event = Factory(:event, :admin_submitted => true)
    end

    should "not send out notification email after creation" do
      @emails.clear
      @event_observer.after_create(@event)
      assert_equal 0, @emails.size
    end
  end
  
end
