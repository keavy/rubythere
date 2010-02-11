require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  context "on GET to :index" do
    setup {get :index}
    should_respond_with :success
    should_assign_to :events
  end
end
