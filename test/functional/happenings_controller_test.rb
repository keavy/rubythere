require 'test_helper'

class HappeningsControllerTest < ActionController::TestCase
  def setup
    @user  = Factory(:user)
    login_as @user
    @event     = Factory(:event, :twitter => @user.screen_name)
  end
  
  context "on GET to :index" do
    context "for an event with happening(s)" do
      setup do 
        @happening = Factory(:happening, :event => @event)
        get :index, :event_id => @event
      end

      should_respond_with :success
      should_assign_to :happenings
    end
    
    context "for an event with no happenings" do
      setup do
        @event.happenings.delete
        get :index, :event_id => @event
      end

      should_assign_to :happening
      should "setup a location for the happening" do
        assert_not_nil assigns(:happening).location
      end
    end
  end
  
  context "on GET to :new" do
    setup { get :new, :event_id => @event}
    
    should_respond_with :success
  end
  
end
