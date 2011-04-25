require 'spec_helper'

describe Event do
  describe 'validations' do
    let(:event){Event.new}

    it 'requires a name' do
      event.valid?
      event.errors.full_messages.should include "Name can't be blank"
    end
  end

  describe "#before_save" do
    it "should write value for description_formatted" do
      @event = Factory(:event)
      @event.description = "awesome conf"
      @event.save
      @event.description_formatted.should == "<p>awesome conf</p>"
    end
  end

  it "shouldn't allow mass assignment of submitter" do
    dodgy = Factory(:user)
    @event = Factory(:event)
    @event.update_attributes(:submitter => dodgy)
    @event.reload.submitter.should_not == dodgy
  end

  it "should send an email on event creation" do
    Mailer.expects(:deliver_new_event_notification)
    Event.create(valid_event_params)
  end
end