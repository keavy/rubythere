require 'test_helper'

class SpeakerTest < ActiveSupport::TestCase
  should_validate_presence_of :first_name
  should_validate_presence_of :last_name
  should_validate_presence_of :email
end
