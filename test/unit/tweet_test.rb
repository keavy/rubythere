ENV["Rails.env"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../../config/environment.rb")
require 'test/unit'


class TweetTest < ActiveSupport::TestCase
  context "calling .messages_for a phrase" do
    setup do
      @tweets = Tweet.messages_for('scotruby')
    end

    should "return an array" do
      assert_equal @tweets.class, Array
    end
  end
  
end
