require 'spec_helper'

shared_examples_for "rubythere.com email" do
  it "should have a prefix on the subject" do
    @email.subject.should =~ /\[RubyThere\]\s/
  end
end

describe Mailer do
  describe "when sending a new event email" do
    before(:each) do
      @event = Factory(:event)
      @email = Mailer.new_event_notification(@event)
    end

    it "should be sent to the EMAIL_CONTACT address" do
      @email.to.should == ["#{EMAIL_CONTACT}"]
    end

    it "should be sent from the submitter's email address" do
      @email.from.should == ["#{@event.submitter.email}"]
    end

    it_should_behave_like "rubythere.com email"
  end
end