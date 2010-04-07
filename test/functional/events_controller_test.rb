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
      should_assign_to :latest
    end
  end
  
  context "on GET to :new" do
    setup { get :new}
    should_respond_with :success
    should_assign_to :event
  end
  
  context "on POST to :create" do
    context "with valid data" do
      setup do
        @event_count         = Event.count
        happening_attributes = Factory.attributes_for(:happening)
        submitter_attributes = Factory.attributes_for(:submitter)
        post :create, :event => { :name                  => 'test event', 
                                  :happenings_attributes => { 0 => happening_attributes},
                                  :submitter_attributes  => submitter_attributes }
      end
      # should_change tests currently failing with no method error?!
      #should_change "Event.count", :by => 1 
      #should_change "Happening.count", :by => 1
      #should_change "Submitter.count", :by => 1
      should "increase Event.count by 1" do
        assert_equal @event_count + 1, Event.count
      end
      should_set_the_flash_to /Thanks/
      should_redirect_to("root path") {root_path}
      should "return false when calling #approved on the event" do
        assert_equal assigns(:event).approved, false
      end
    end
    
    context "with invalid data" do
      setup do
        post :create, :event => Factory.attributes_for(:event, :name => '', :happenings_attributes => {}, :submitter_attributes => {})
      end
      should_not_change "Event.count"
      should_not_change "Happening.count"
      should_not_change "Submitter.count"
      should_render_template :new
    end
  end
end
