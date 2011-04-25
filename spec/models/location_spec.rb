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
        location = Factory(:location, :city => 'New York', :country => 'United States', :state => nil)
        location.city_state_country.should == 'New York, United States'
      end
    end

    context "with a state and country present" do
      it "returns a string of city and country" do
        location = Factory(:location, :state => 'Colorado', :country => 'United States', :city => nil)
        location.city_state_country.should == 'Colorado, United States'
      end
    end

    context "with just country present" do
      it "returns a string of country" do
        location = Factory(:location, :country => 'France', :state => nil, :city => nil)
        location.city_state_country.should == 'France'
      end
    end
  end
end