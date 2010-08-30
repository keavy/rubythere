require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  context "on GET to :index" do
    setup {get :index}
    should respond_with(:success)
  end
end
