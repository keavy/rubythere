require 'spec_helper'

describe Location do
  describe 'validations' do
    let(:location){Location.new}

    it 'requires a country' do
      location.valid?
      location.errors.full_messages.should include "Country can't be blank"
    end
  end

  describe ".city_state_country" do
    context "with a city and country present" do
      it "returns a string of city and country" do
        location = FactoryGirl.build(:location, :city => 'New York', :country => 'United States', :state => nil)
        location.city_state_country.should == 'New York, United States'
      end
    end

    context "with a state and country present" do
      it "returns a string of city and country" do
        location = FactoryGirl.build(:location, :state => 'Colorado', :country => 'United States', :city => nil)
        location.city_state_country.should == 'Colorado, United States'
      end
    end

    context "with just country present" do
      it "returns a string of country" do
        location = FactoryGirl.build(:location, :country => 'France', :state => nil, :city => nil)
        location.city_state_country.should == 'France'
      end
    end
  end

  describe "#before_save on create" do
    context "with good location details" do
      describe "sets lat_long" do
        location = FactoryGirl.build(:location, :city => 'Dublin', :country => 'Ireland')
        location.stubs(:geocode).returns("50,50")
        location.save
        location.lat_long.should == "50,50"
      end
    end

    context "with bad location details" do
      describe "sets lat_long" do
        location = FactoryGirl.build(:location, :city => 'Internet', :country => 'Brazil')
        location.stubs(:geocode).returns(nil)
        location.save
        location.lat_long.should == nil
      end
    end
  end
end