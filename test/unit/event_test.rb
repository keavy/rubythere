require 'test_helper'

class EventTest < ActiveSupport::TestCase
  should_validate_presence_of :name, :message => '^Please add a name'
end
