require 'test_helper'

class Admin::EventsControllerTest < ActionController::TestCase
  def setup
    @user     = FactoryGirl.create(:user, :admin => 1)
    login_as @user
    @event    = FactoryGirl.create(:event)
    @location = FactoryGirl.create(:location)
  end
  
  context "on GET to :index" do
    setup do
      get :index
    end

    should respond_with(:success)
  end
  
  context "on GET to :new" do
    setup { get :new }

    should respond_with(:success)
  end
  
  context "on POST to :create" do
    context "with valid details" do
      setup do
        post :create, :event => Factory.attributes_for(:event, :approved => 1)
      end

      should_change('Event count by 1', :by => 1) { Event.count }
      should_redirect_to("admin events path") {admin_events_path}
      should "return no errors" do
        assert assigns(:event).errors.full_messages.to_sentence.blank?
      end
      should "set the approved field" do
        assert_equal true, assigns(:event).approved
      end
    end
    
    context "with invalid details" do
      setup do
        post :create, :event => Factory.attributes_for(:event, :name => '')
      end
      
      should_not_change('Event count') { Event.count }
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
                                    }
                                  }
      end

      should_change('Event count by 1', :by => 1) { Event.count }
      should_change('Happening count by 1', :by => 1) { Happening.count }
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
                                    }
                                  }
      end

      should_change('Event count by 1', :by => 1) { Event.count }
      should_change('Happening count by 1', :by => 1) { Happening.count }
      should_change('Location count by 1', :by => 1) { Location.count }

      should "set the event happening location to the new location" do
        assert_equal assigns(:event).happenings.first.location.country, "Australia"
      end
    end
  end

  context "on GET to :edit" do
    setup { get :edit, :id => @event.id }

    should respond_with(:success)
  end
  
  context "on PUT to :update" do
    context "with valid details" do
      setup do
        put :update, :event => Factory.attributes_for(:event, :name => 'updated', :approved => 0), :id => @event.id
      end

      should_redirect_to("event path") {event_path(assigns(:event))}
      should "update the name" do
        assert_equal 'updated', assigns(:event).name
      end
      should "set the approved field" do
        assert_equal false, assigns(:event).approved
      end
    end
    
    context "with invalid details" do
      setup do
        put :update, :event => Factory.attributes_for(:event, :name => ''), :id => @event.id
      end
      
      should_render_template :edit
    end
  end
  
  
end
