require 'spec_helper'

describe Submitter do
  describe 'validations' do
    let(:submitter){Submitter.new}

    it 'requires a first_name' do
      submitter.should_not be_valid
      submitter.should have(1).error_on(:first_name)
      submitter.errors.full_messages.should include "First name can't be blank"
    end
  end

  describe "#full_name" do
    it "returns first and last name concatenated" do
      submitter = Submitter.new(:first_name => "Jess", :last_name => 'Jones')
      submitter.full_name.should == "Jess Jones"
    end
  end
end