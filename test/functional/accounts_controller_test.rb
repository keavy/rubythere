require 'test_helper'

class AccountsControllerTest < ActionController::TestCase
  def setup
    @user = Factory(:user)
    login_as @user
  end
  
  context "on GET to :show" do
    setup do
      Factory(:event, :twitter => @user.screen_name)
      get :show
    end

    should_respond_with :success
    should_assign_to :events
  end
end
