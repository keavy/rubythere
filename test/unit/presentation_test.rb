require 'test_helper'

class PresentationTest < ActiveSupport::TestCase
  should_validate_presence_of :speaker_id
  should_validate_presence_of :happening_id
end
