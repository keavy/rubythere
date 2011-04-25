require 'spec_helper'

describe Tweet do
  describe ".messages_for" do
    before do
      stub_request(:get, "https://search.twitter.com/search.json").
        with(:query => {:q => "scotruby"}).
        to_return(:body => fixture("tweets.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    end

    it "returns an array" do
      Tweet.messages_for('scotruby').class.should == Array
    end

    it "returns up to size set in limit" do
      Tweet.messages_for('scotruby', 2).size.should <= 2
    end
  end
end