require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  should_validate_presence_of :city, :message => '^Please add a city'
  should_validate_presence_of :country, :message => '^Please add a country'
end
