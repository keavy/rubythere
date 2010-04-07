require 'test_helper'

class FeedsControllerTest < ActionController::TestCase
  def setup
    @event     = Factory(:event)
    @happening = Factory(:happening, :event => @event)
  end
  
  context "on GET to :index" do
    context "with format of 'rss'" do
      setup { get :index, :format => 'rss'}
      should_respond_with :success
    end
    
    context "with format of 'xml'" do
      setup { get :index, :format => 'xml'}
      should_respond_with :success
    end
  end
end
