title = "Ruby There"
author = "Keavy McMinn"
description = "Events of interest to Rubyists around the world"
image = ""

xml.instruct!
xml.rss "version" => "2.0", "xmlns:dc" => "http://purl.org/dc/elements/1.1/" do  xml.channel do 
    xml.title title
    xml.link 'http://events.keavy.co.uk'
    xml.description description
    xml.language 'en'

    @happenings.each do |happening|
      xml.item do
        xml.title "#{happening.event.name}"
        xml.description do
          xml << h(render(:partial => 'feed_desc', :object => happening))
        end
        
        xml.pubDate happening.created_at.to_s(:rfc822)
        xml.link event_url(happening.event)
      end
    end
  end
end