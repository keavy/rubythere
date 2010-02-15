require 'test_helper'

class Admin::EventsControllerTest < ActionController::TestCase
  setup :activate_authlogic
  
  def setup
    @user = Factory(:user)
    login_as @user
    @event = Factory(:event)
  end
  
  context "on GET to :index" do
    setup do
      get :index
    end

    should_respond_with :success
  end
  
  context "on GET to :new" do
    setup { get :new }

    should_respond_with :success
  end
  
  context "on POST to :create" do
    context "with valid details" do
      setup do
        post :create, :event => Factory.attributes_for(:event)
      end

      should_change('Event count by 1', :by => 1) { Event.count }
      should_redirect_to("admin events path") {admin_events_path}
      should "return no errors" do
        assert assigns(:event).errors.full_messages.to_sentence.blank?
      end
    end
    
    context "with invalid details" do
      setup do
        post :create, :event => Factory.attributes_for(:event, :name => '')
      end
      
      should_not_change('Event count') { Event.count }
      should_render_template :new
    end
  end

  context "on GET to :edit" do
    setup { get :edit, :id => @event.id }

    should_respond_with :success
  end
  
  context "on PUT to :update" do
    context "with valid details" do
      setup do
        put :update, :event => Factory.attributes_for(:event, :name => 'updated'), :id => @event.id
      end

      should_redirect_to("admin events path") {admin_events_path}
      should "update the name" do
        assert_equal 'updated', assigns(:event).name
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
