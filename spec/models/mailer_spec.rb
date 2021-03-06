require 'spec_helper'

shared_examples_for "rubythere.com email" do
end

describe Mailer do
  describe "when sending a new event email" do
    before(:each) do
      @event = FactoryGirl.create(:event)
      @email = Mailer.new_event_notification(@event)
    end

    it "should be sent to the EMAIL_CONTACT address" do
      @email.to.should == ["#{EMAIL_CONTACT}"]
    end

    it "should be sent from the EMAIL_CONTACT address" do
      @email.from.should == ["#{EMAIL_CONTACT}"]
    end

    it "should be reply-to the submitter's email address" do
      p @email
      @email.reply_to.should == ["#{@event.submitter.email}"]
    end

    it "subject should be 'New event submitted'" do
      @email.subject.should == 'New event submitted'
    end

    it_should_behave_like "rubythere.com email"
  end

  describe "when sending a new user notification" do
    before(:each) do
      @user  = FactoryGirl.create(:user)
      @email = Mailer.new_user_notification(@user)
    end

    it "should contain the user's screen name" do
      @email.body.should =~ /#{@user.screen_name}/
    end

    it "should be sent to the EMAIL_CONTACT address" do
      @email.to.should == ["#{EMAIL_CONTACT}"]
    end

    it "should be sent from the EMAIL_CONTACT address" do
      @email.from.should == ["#{EMAIL_CONTACT}"]
    end
  end
end