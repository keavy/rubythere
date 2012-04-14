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
      @event = FactoryGirl.create(:event)
      @event.description = "awesome conf"
      @event.save
      @event.description_formatted.should == "<p>awesome conf</p>"
    end
  end

  it "shouldn't allow mass assignment of submitter" do
    dodgy = FactoryGirl.create(:user)
    @event = FactoryGirl.create(:event)
    @event.update_attributes(:submitter => dodgy)
    @event.reload.submitter.should_not == dodgy
  end
end