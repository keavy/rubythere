require 'spec_helper'

describe Event do
  before do
    @event = Factory(:event)
  end

  it "should be invalid without a name" do
    event = Event.new :name => nil
    event.should_not be_valid
    event.should have(1).error_on(:name)
  end

  describe "#before_save" do
    it "should write value for description_formatted" do
      @event.description = "awesome conf"
      @event.save
      @event.description_formatted.should == "<p>awesome conf</p>"
    end
  end

  it "shouldn't allow mass assignment of submitter" do
    dodgy = Factory(:user)
    @event.update_attributes(:submitter => dodgy)
    @event.reload.submitter.should_not == dodgy
  end

  it "should send an email on event creation" do
    Mailer.expects(:deliver_new_event_notification)
    Event.create(valid_event_params)
  end
end