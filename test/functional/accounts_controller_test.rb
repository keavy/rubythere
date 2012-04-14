require 'test_helper'

class AccountsControllerTest < ActionController::TestCase
  def setup
    @user = FactoryGirl.create(:user)
    login_as @user
  end
  
  context "on GET to :show" do
    setup do
      FactoryGirl.create(:event, :twitter => @user.screen_name)
      get :show
    end

    should respond_with(:success)
    should_assign_to :events
  end
end
