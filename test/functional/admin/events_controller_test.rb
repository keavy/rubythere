require 'test_helper'

class Admin::EventsControllerTest < ActionController::TestCase
  def setup
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

      should_change "Event.count", :by => 1
      should_redirect_to("admin event path") {admin_event_path(assigns(:event))}
      should "return no errors" do
        assert assigns(:event).errors.full_messages.to_sentence.blank?
      end
    end
    
    context "with invalid details" do
      setup do
        post :create, :event => Factory.attributes_for(:event, :name => '')
      end

      should_not_change "Event.count"
      should_render_template :new
    end
  end
  
  context "on GET to :show" do
    setup { get :show, :id => @event}
    should_respond_with :success
  end
  
  
end
