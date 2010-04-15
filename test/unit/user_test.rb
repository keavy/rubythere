require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    Factory(:user)
  end
  
  should_allow_mass_assignment_of :atoken
  should_allow_mass_assignment_of :asecret
  should_validate_uniqueness_of :screen_name
  
  context "authorized?" do
    setup do
      @user = User.new
    end
    
    should "be false if missing atoken and asecret" do
      @user.authorized?.should be(false)
    end
    
    should "be false if missing atoken" do
      @user.atoken = nil
      @user.asecret = 'some secret'
      @user.authorized?.should be(false)
    end
    
    should "be false if missing asecret" do
      @user.atoken = 'some token'
      @user.asecret = nil
      @user.authorized?.should be(false)
    end
    
    should "be true if both atoken and asecret present" do
      @user.atoken = 'some token'
      @user.asecret = 'some secret'
      @user.authorized?.should be(true)
    end
  end
  
  should "have oauth helper" do
    user = User.new
    user.oauth.class.should == Twitter::OAuth
  end
  
  context "twitter client object" do
    setup do
      @user = User.new(:atoken => 'atoken', :asecret => 'asecret')
      @oauth = Twitter::OAuth.new('token', 'secret')
      @user.stubs(:oauth).returns(@oauth)
    end

    should "authorize from access token and secret" do
      @user.expects(:oauth).returns(@oauth)
      @oauth.expects(:authorize_from_access).with('atoken', 'asecret').returns(nil)
      @user.client
    end
    
    should "return twitter base object" do
      @user.client.class.should == Twitter::Base
    end
  end
  
  context "calling #events on a User" do
    setup do
      @user = Factory(:user)
      Factory(:event, :twitter => @user.screen_name)
    end

    should "return an array of events" do
      assert_equal 1, @user.events.size
    end
  end
  
end
