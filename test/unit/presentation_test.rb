require 'test_helper'

class PresentationTest < ActiveSupport::TestCase
  should_belong_to :speaker
  should_belong_to :talk
  should_belong_to :happening
end
