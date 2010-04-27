require 'test_helper'

class SearchesControllerTest < ActionController::TestCase
  context "on GET to :show" do
    context "with a query" do
      setup {get :show, :q => 'blah'}

      should_respond_with :success
      should_assign_to :events
    end

    context "with no query" do
      setup {get :show}

      should_respond_with :success
      should_not_assign_to :events
    end
  end
  
end
