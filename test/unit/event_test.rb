require 'test_helper'

class EventTest < ActiveSupport::TestCase
  should_belong_to :location
  should_belong_to :venue
  should_validate_presence_of :name, :message => '^Please add a name'

  context "calling #status on an event" do
    
    context "which is open for registration" do
      setup { @event = Factory.build(:event, :reg_open => 1) }
      
      should "return 'open_for_reg'" do
        assert_equal 'open_for_reg', @event.status
      end
    end
    
    context "which is sold out" do
      setup { @event = Factory.build(:event, :reg_open => 1, :sold_out => 1) }
      
      should "return 'sold_out'" do
        assert_equal 'sold_out', @event.status
      end
    end
    
    context "which is not sold out or open for reg" do
      setup { @event = Factory.build(:event, :reg_open => 0, :sold_out => 0) }
      
      should "return 'unknown'" do
        assert_equal 'unknown', @event.status
      end
    end
    
  end
end
