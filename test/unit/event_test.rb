require 'test_helper'

class EventTest < ActiveSupport::TestCase
  should_have_many :happenings
  should_belong_to :submitter
  should_validate_presence_of :name, :message => '^Please add a name'
end
