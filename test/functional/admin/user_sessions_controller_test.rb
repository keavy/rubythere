require 'test_helper'

class Admin::UserSessionsControllerTest < ActionController::TestCase
  setup :activate_authlogic

  context "on GET to :new" do
    setup { get :new}
    should_respond_with :success
  end
  
  context "on POST to :create" do
    setup do
      @user = Factory(:user)
      post :create, :user_session => {:email => @user.email, :password => @user.password}
    end
    
    should_assign_to :user_session
    should "set the user_session user to the user passed" do
      assert_equal @user, assigns(:user_session).user
    end
    
    should_redirect_to("Admin events path") { admin_events_path }
  end
  
  context "on DELETE to :destroy" do
    setup do
      @user = Factory(:user)
      login_as @user
      delete :destroy
    end
    
    should "clear the UserSession" do
      assert_nil UserSession.find
    end
    
    should_redirect_to("Root path") { root_path }
  end
end
