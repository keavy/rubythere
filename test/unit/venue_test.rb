require 'test_helper'

class VenueTest < ActiveSupport::TestCase
  should_belong_to :location
  should_validate_presence_of :name, :message => '^Please add a name'
end
