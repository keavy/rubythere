require 'test_helper'

class PresentationTest < ActiveSupport::TestCase
  should_belong_to :speaker
  should_belong_to :talk
  should_belong_to :happening
  
  should_validate_presence_of :speaker_id
  should_validate_presence_of :happening_id
end
