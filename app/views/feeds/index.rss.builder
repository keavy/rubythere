title = "Ruby There"
author = "Keavy McMinn"
description = "Events of interest to Rubyists around the world"
image = ""

xml.instruct!
xml.rss "version" => "2.0", "xmlns:atom" => "http://www.w3.org/2005/Atom" do  
  xml.channel do 
    xml.title title
    xml.link 'http://www.rubythere.com'
    xml.description description
    xml.language 'en'
    xml.atom :link, :href=> "http://www.rubythere.com/feeds.rss", :rel=>"self", :type=>"application/rss+xml"

    @happenings.each do |happening|
      next if happening.event.nil?
      xml.item do
        xml.title "#{happening.event.name}"
        xml.description do
          xml << h(render(:partial => 'feed_desc', :object => happening))
        end
        
        xml.pubDate happening.created_at.to_s(:rfc822)
        xml.link event_url(happening.event)
        xml.guid event_url(happening.event)
      end
    end
  end
end