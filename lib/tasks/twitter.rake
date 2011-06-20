#include ActionController::Caching::Fragments

namespace :twitter do
  desc "Fetch tweets for events"
  task :fetch_tweets => :environment do
    ac = ActionController::Base.new
    av = ActionView::Base.new(Rails.root.join('app', 'views'))
    events = Event.all
    events.each do |e|
      unless e.twitter.blank?
        key = "tweets/event_#{e.id}"
        content = av.render :partial => "events/tweet", :collection => Tweet.messages_for(e.twitter,4)
        ac.write_fragment(key, content, options = nil)
        puts "tweets written for #{e.name}"
      end
    end
  end
end