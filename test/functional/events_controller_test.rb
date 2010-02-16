require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  context "on GET to :show" do
    setup do
      @event = Factory(:event)
      get :show, :id => @event
    end
    should_respond_with :success
    should_assign_to :event
    
    context "with an upcoming happening" do
      setup do
        @happening = Factory(:happening, :event => @event, :start_at => 2.months.from_now)
        get :show, :id => @event
      end

      should_respond_with :success
      should_assign_to :upcoming
    end
  end
end
