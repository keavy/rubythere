require 'test_helper'

class HappeningsControllerTest < ActionController::TestCase
  def setup
    @user  = FactoryGirl.create(:user)
    login_as @user
    @event     = FactoryGirl.create(:event, :twitter => @user.screen_name)
  end
  
  context "on GET to :index" do
    context "for an event with happening(s)" do
      setup do 
        @happening = FactoryGirl.create(:happening, :event => @event)
        get :index, :event_id => @event
      end

      should respond_with(:success)
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
    
    should respond_with(:success)
  end
  
  context "on GET to :edit" do
    setup do
      @happening = FactoryGirl.create(:happening, :event => @event)
      get :edit, :id => @happening
    end

    should respond_with(:success)
    should_assign_to :happening
    should_assign_to :event
  end
  
  context "on PUT to :update" do
    setup {@happening = FactoryGirl.create(:happening, :event => @event)}
    
    context "with new location details" do
      setup do
        @happening.location.delete
        put :update, :id => @happening,
                      :happening => {
                        :location_attributes => {
                           :city    => "Sydney",
                           :country => "Australia",
                           :state   => ""
                          },
                        :location_id => "" 
                      }
                      
      end

      should_set_the_flash_to /Thanks/
      should_respond_with :redirect
      should "set the happening location to the new location" do
        assert_equal assigns(:happening).location.country, "Australia"
        assert_equal assigns(:happening).location.city, "Sydney"
      end
    end
      
    context "with existing location details" do
      setup do
        @location = FactoryGirl.create(:location)
        put :update, :id => @happening,
                      :happening => {
                        :location_attributes => {
                           :city    => "",
                           :country => "",
                           :state   => ""
                          },
                        :location_id => @location.id
                      }

      end

      should_set_the_flash_to /Thanks/
      should_respond_with :redirect
      should "set the happening location to the new location" do
        assert_equal assigns(:happening).location.country, @location.country
        assert_equal assigns(:happening).location.city, @location.city
      end
    end

    context "with invalid details" do
      setup do
        put :update, :happening => {:url => ''}, :id => @happening
      end

      should respond_with(:success)
      should_render_template :edit
    end
  end
  
  context "on POST to :create" do
    setup do
      post :create, :happening => Factory.attributes_for(:happening), :event_id => @event
    end
    
    should_set_the_flash_to /Thanks/
    should_respond_with :redirect
  end
  
end
