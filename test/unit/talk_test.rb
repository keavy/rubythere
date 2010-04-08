require 'test_helper'

class TalkTest < ActiveSupport::TestCase
  should_have_many :presentations
  
  should_validate_presence_of :title
end
