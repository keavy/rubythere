require 'test_helper'

class UserObserverTest < ActiveSupport::TestCase
  def setup
    ActionMailer::Base.delivery_method    = :test
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries         = []
    @emails                               = ActionMailer::Base.deliveries
    @user_observer                        = UserObserver.instance
  end
  
  context "a new user is created" do
    setup do
      @user = Factory(:user)
    end

    should "send out notification email after creation" do
      @emails.clear
      @user_observer.after_create(@user)
      assert_equal 1, @emails.size
    end
  end
end
