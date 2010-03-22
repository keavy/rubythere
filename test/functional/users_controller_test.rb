require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  context "on GET to :new" do
    setup {get :new}
    should_respond_with :success
  end
end
