require 'spec_helper'

describe Happening do
  describe "validation" do
    let(:happening){Happening.new}

    it "requires a URL" do
      happening.valid?
      happening.errors.full_messages.should include "Url can't be blank"
    end

    it "requires start_at" do
      happening.should_not be_valid
      happening.should have(1).error_on(:start_at)
    end
  end

  describe "#status" do
    context "when open for registration" do
      it "should return 'Open for registration'" do
        happening = Factory.build(:happening, :event => @event, :open_for_reg => 1, :start_at => 1.month.from_now)
        happening.status == 'Open for registration'
      end

      context "but in the past" do
        it "should return blank" do
          happening = Factory.build(:happening, :event => @event, :open_for_reg => 1, :start_at => 1.month.ago)
          happening.status.should be_blank
        end
      end
    end

    context "which is sold out" do
      it "should return 'Sold out'" do
        happening = Factory.build(:happening, :event => @event, :sold_out => 1)
        happening.status == 'Sold out'
      end
    end

    context "which is not sold out or open for reg" do
      it "should return blank" do
        happening = Factory.build(:happening, :event => @event, :open_for_reg => 0, :sold_out => 0)
        happening.status.should be_blank
      end
    end
  end

  describe "#summary" do
    it "should return a string that includes the event name" do
      happening = Factory(:happening)
      happening.summary.include?(happening.event.name).should be true
    end
  end
end