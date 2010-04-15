require 'test_helper'

class HappeningsControllerTest < ActionController::TestCase
  def setup
    @user  = Factory(:user)
    login_as @user
    
    @event     = Factory(:event, :twitter => @user.screen_name)
    @happening = Factory(:happening, :event => @event)
  end
  
  context "on GET to :index" do
    setup { get :index, :event_id => @event }
    
    should_respond_with :success
    should_assign_to :happenings
  end
end
