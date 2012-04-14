require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  context "on GET to :show" do
    context "for an event with twitter name" do
      setup do
        @event = FactoryGirl.create(:event)
        get :show, :id => @event
      end
      should respond_with(:success)
      should_assign_to :event

      context "with an upcoming happening" do
        setup do
          @happening = FactoryGirl.create(:happening, :event => @event, :start_at => 2.months.from_now)
          get :show, :id => @event
        end

        should respond_with(:success)
        should_assign_to :latest
      end
    end
    context "for an event without twitter name" do
      setup do
        @event = FactoryGirl.create(:event, :twitter => '')
        get :show, :id => @event
      end
      should respond_with(:success)
      should_assign_to :event
    end
  end
  
  context "on GET to :new" do
    setup { get :new}
    should respond_with(:success)
    should_assign_to :event
  end
  
  context "on POST to :create" do
    setup do 
      @location             = FactoryGirl.create(:location)
      @submitter_attributes = Factory.attributes_for(:submitter)
    end
    
    context "with valid data" do
      setup do
        @event_count         = Event.count
        happening_attributes = Factory.attributes_for(:happening)
        
        post :create, :event => { :name                  => 'test event', 
                                  :happenings_attributes => { 0 => happening_attributes},
                                  :submitter_attributes  => @submitter_attributes }
      end
      should_change('Event count by 1', :by => 1) { Event.count }
      should_change('Happening count by 1', :by => 1) { Happening.count }
      should_change('Submitter count by 1', :by => 1) {Submitter.count }
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
      should_not_change ("Event.count") {Event.count}
      should_not_change ("Happening.count") {Happening.count}
      should_not_change ("Submitter.count") {Submitter.count}
      should_render_template :new
    end
    
    context "including happening and existing location details" do
      setup do
        @count    = Event.count
        post :create, :event => { :name => 'test',
                                  :happenings_attributes =>{
                                     "0"=>{
                                       :start_at => '2010-03-02',
                                       :url      => 'http://www.test.com',
                                       :location_attributes => {
                                         :city    => "",
                                         :country => "",
                                         :state   => ""
                                        },
                                       :location_id => @location.id }
                                    },
                                    :submitter_attributes  => @submitter_attributes
                                  }
      end

      should_change('Event count by 1', :by => 1) { Event.count }
      should_change('Happening count by 1', :by => 1) { Happening.count }
      should_change('Submitter count by 1', :by => 1) {Submitter.count }
      should_not_change('Location count') { Location.count }
      
      should "set the event happening location to the existing location" do
        assert_equal assigns(:event).happenings.first.location_id, @location.id
      end
    end
    
    context "including happening and new location details" do
      setup do
        @count    = Event.count
        post :create, :event => { :name => 'test',
                                  :happenings_attributes =>{
                                     "0"=>{
                                       :start_at => '2010-03-02',
                                       :url      => 'http://www.test.com',
                                       :location_attributes => {
                                         :city    => "Sydney",
                                         :country => "Australia",
                                         :state   => ""
                                        },
                                       :location_id => "" }
                                    },
                                    :submitter_attributes  => @submitter_attributes
                                  }
      end

      should_change('Event count by 1', :by => 1) { Event.count }
      should_change('Happening count by 1', :by => 1) { Happening.count }
      should_change('Submitter count by 1', :by => 1) {Submitter.count }
      should_change('Location count by 1', :by => 1) { Location.count }

      should "set the event happening location to the new location" do
        assert_equal assigns(:event).happenings.first.location.country, "Australia"
        assert_equal assigns(:event).happenings.first.location.city, "Sydney"
      end
    end
    
    context "including happening and existing location details, entered as new" do
      setup do
        post :create, :event => { :name => 'test',
                                  :happenings_attributes =>{
                                     "0"=>{
                                       :start_at => '2010-03-02',
                                       :url      => 'http://www.test.com',
                                       :location_attributes => {
                                         :city    => @location.city,
                                         :country => @location.country,
                                         :state   => ""
                                        },
                                       :location_id => "" }
                                    },
                                    :submitter_attributes  => @submitter_attributes
                                  }
      end

      should "set the event happening location to the existing location" do
        assert_equal assigns(:event).happenings.first.location, @location
      end
    end
  end
  
  context "on GET to :edit" do
    setup do
      @user  = FactoryGirl.create(:user)
      login_as @user
    end
    
    context "for an event the user is authorized to edit" do
      setup do
        @event = FactoryGirl.create(:event, :twitter => @user.screen_name)
        get :edit, :id => @event
      end

      should respond_with(:success)
    end
    
    context "for an event the user is not authorized to edit" do
      setup do
        @event = FactoryGirl.create(:event, :twitter => 'something')
        get :edit, :id => @event
      end

      should_respond_with :redirect
      should_set_the_flash_to 'You are not authorized to view the page you requested'
    end
  end
  
  context "on GET to :index" do
    def setup
      @event     = FactoryGirl.create(:event)
      @happening = FactoryGirl.create(:happening, :event => @event)
    end
    
    context "with 'focus' param of 'attend'" do
      setup { get :index, :focus => 'attend'}
      should_assign_to :focus
      should_assign_to :happenings
    end
    
    context "with 'focus' param of 'speak'" do
      setup { get :index, :focus => 'speak'}
      should_assign_to :focus
      should_assign_to :happenings
    end
    
    context "with no 'focus' param'" do
      setup { get :index}
      should_assign_to :focus
      should_assign_to :happenings
    end
  end
  
  context "on PUT to :update" do
    setup do 
      @user = FactoryGirl.create(:user)
      login_as @user
      @event     = FactoryGirl.create(:event, :twitter => @user.screen_name)
      #@happening = FactoryGirl.create(:happening, :event => @event)
      @location             = FactoryGirl.create(:location)
      @submitter_attributes = Factory.attributes_for(:submitter)
    end
    
    context "with valid data" do
      setup do
        happening_attributes = Factory.attributes_for(:happening)
        
        put :update, :id => @event.id,
                     :event => { :name                  => 'test event', 
                                 :happenings_attributes => { 0 => happening_attributes}}
      end
      should_change('Happening count by 1', :by => 1) { Happening.count }
      should_set_the_flash_to /Thanks/
      should_redirect_to("event path") {event_path(assigns(:event))}
    end
  end
  
  
end
