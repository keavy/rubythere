require 'test_helper'

class FeedsControllerTest < ActionController::TestCase
  def setup
    @event     = FactoryGirl.create(:event)
    @happening = FactoryGirl.create(:happening, :event => @event)
  end
  
  context "on GET to :index" do
    context "with format of 'rss'" do
      setup { get :index, :format => 'rss'}
      should respond_with(:success)
    end
    
    context "with format of 'xml'" do
      setup { get :index, :format => 'xml'}
      should respond_with(:success)
    end
  end
end
