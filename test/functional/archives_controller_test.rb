require 'test_helper'

class ArchivesControllerTest < ActionController::TestCase
  def setup
    @event     = Factory(:event)
    @happening = Factory(:happening, :event => @event)
  end
  
  context "on GET to :show" do
    setup { get :show}
    should respond_with(:success)
    should_assign_to :happenings
  end
end
