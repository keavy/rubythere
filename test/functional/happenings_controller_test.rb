require 'test_helper'

class HappeningsControllerTest < ActionController::TestCase
  def setup
    @event     = Factory(:event)
    @happening = Factory(:happening, :event => @event)
  end
  
  context "on GET to :archive" do
    setup { get :archive}
    should_respond_with :success
    should_assign_to :happenings
  end
  
  context "on GET to :index" do
    context "with 'focus' param of 'attend'" do
      setup { get :index, :focus => 'attend'}
      should_assign_to :focus
      should_assign_to :happenings
      
      context "with format of 'rss'" do
        setup { get :index, :focus => 'attend', :format => 'rss'}
        should_respond_with :success
      end
    end
    
    context "with 'focus' param of 'speak'" do
      setup { get :index, :focus => 'speak'}
      should_assign_to :focus
      should_assign_to :happenings
      
      context "with format of 'rss'" do
        setup { get :index, :focus => 'speak', :format => 'rss'}
        should_respond_with :success
      end
    end
    
    context "with no 'focus' param'" do
      setup { get :index}
      should_assign_to :focus
      should_assign_to :happenings
      
      context "with format of 'rss'" do
        setup { get :index, :format => 'rss'}
        should_respond_with :success
      end
    end
  end
end