require 'test_helper'

class HappeningTest < ActiveSupport::TestCase
  should_belong_to :event
  should_belong_to :location
  should_belong_to :venue
  
  def setup
    @event = Factory.build(:event)
  end
  
  context "calling #status on a happening" do
    
    context "which is open for registration" do
      setup { @happening = Factory.build(:happening, :event => @event, :open_for_reg => 1) }
      
      should "return 'open_for_reg'" do
        assert_equal 'open_for_reg', @happening.status
      end
    end
    
    context "which is sold out" do
      setup { @happening = Factory.build(:happening, :event => @event, :sold_out => 1) }
      
      should "return 'sold_out'" do
        assert_equal 'sold_out', @happening.status
      end
    end
    
    context "which is not sold out or open for reg" do
      setup { @happening = Factory.build(:happening, :event => @event, :open_for_reg => 0, :sold_out => 0) }
      
      should "return 'unknown'" do
        assert_equal 'unknown', @happening.status
      end
    end
    
  end
end
