require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  should_have_many :happenings
  should_have_many :venues
  should_validate_presence_of :country, :message => '^Please add a country'
end
