require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  should_have_many :happenings
  should_have_many :venues
  should_validate_presence_of :country, :message => '^Please add a country'
  
  context "calling #city_state_country on a location" do
    context "with a city and country" do
      setup {@location = Factory.build(:location, :city => 'Glasgow', :country => 'UK')}
      
      should "return the city and country" do
        assert_equal 'Glasgow, UK', @location.city_state_country
      end
    end
    
    context "with a city, state and country" do
      setup {@location = Factory.build(:location, :city => 'Baltimore', :state => 'Maryland', :country => 'United States')}
      
      should "return the city, state and country" do
        assert_equal 'Baltimore, Maryland, United States', @location.city_state_country
      end
    end
    
    context "with a country" do
      setup {@location = Factory.build(:location, :city => nil, :state => nil, :country => 'India')}
      
      should "return the country" do
        assert_equal 'India', @location.city_state_country
      end
    end
  end
end
