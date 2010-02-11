require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  def setup
    @event = Factory(:event)
  end
  
  context "on GET to :show" do
    setup { get :show, :id => @event}
    should_respond_with :success
    should_assign_to :event
  end
end
