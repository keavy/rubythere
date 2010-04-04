require 'test_helper'

class SubmitterTest < ActiveSupport::TestCase
  should_have_many :events
  
  should_validate_presence_of :first_name, :message => "^Please enter your first name"
  should_validate_presence_of :last_name, :message => "^Please enter your last name"
  should_validate_presence_of :email, :message => "^Please enter your email"
  
  context "a submitter" do
    setup do
      @submitter = Factory(:submitter)
    end

    should "return the fist and last names when calling #full_name" do
      assert_equal "John Smith", @submitter.full_name
    end
  end
  
end
