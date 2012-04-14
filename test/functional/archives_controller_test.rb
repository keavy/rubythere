require 'test_helper'

class ArchivesControllerTest < ActionController::TestCase
  def setup
    @event     = FactoryGirl.create(:event)
    @happening = FactoryGirl.create(:happening, :event => @event)
  end
  
  context "on GET to :show" do
    setup { get :show}
    should respond_with(:success)
    should_assign_to :happenings
  end
end
