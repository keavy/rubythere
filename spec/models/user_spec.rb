require 'spec_helper'

describe User do
  before do
    @user = Factory(:user)
  end

  describe "validation" do
  end

  describe "protected attributes" do
    it "allows mass assignment of atoken" do
      @user.save!
      @user.update_attributes(:atoken => 'whatever')
      @user.reload.atoken.should == 'whatever'
    end

    it "allows mass assignment of asecret" do
      @user.save!
      @user.update_attributes(:asecret => 'whatever')
      @user.reload.asecret.should == 'whatever'
    end
  end

  describe "#events" do
    context "when the user isn't associated with any events" do
      it "returns an empty array" do
        @user.events.should be_empty
      end
    end

    context "when the user is associated with events" do
      it "returns an array of events" do
        event = Factory(:event, :twitter => @user.screen_name)
        @user.events.include?(event).should be_true
      end
    end
  end
end