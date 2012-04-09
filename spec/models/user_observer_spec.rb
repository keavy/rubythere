require 'spec_helper'

describe UserObserver do
  describe ".after_create" do
    it "calls .deliver on new_user_notification object" do
      user     = Factory(:user)
      observer = UserObserver.instance

      mail_mock = mock()
      mail_mock.expects(:deliver)
      Mailer.expects(:new_user_notification).with(user).returns(mail_mock)

      observer.after_create(user)
    end
  end
end