title = "Upcoming events"
author = "Keavy McMinn"
description = "Events of interest to Rubyists around the world"
image = ""

xml.instruct!
xml.rss "version" => "2.0", "xmlns:dc" => "http://purl.org/dc/elements/1.1/" do  xml.channel do 
    xml.title title
    xml.link 'http://events.keavy.co.uk'
    xml.description description
    xml.language 'en'
    
    unless @happenings.blank?
      xml.pubDate @happenings.first.created_at.to_s(:rfc822)
      xml.lastBuildDate @happenings.first.created_at.to_s(:rfc822)
    end

    @happenings.each do |happening|
      xml.item do
        xml.title "#{happening.event.name}"
        xml.description do
          xml << h(render(:partial => 'feed_desc', :object => happening))
        end
        
        #xml.pubDate happening.created_at.to_s(:rfc822)
        xml.link event_url(happening.event)
        
        xml.event_description happening.description
        xml.logo_url "http://img.tweetimag.es/i/#{happening.event.twitter}_n" unless happening.event.twitter.blank?
        xml.location happening.location.city_state_country
        xml.event_dates event_date(happening.start_at, happening.end_at)
        xml.start_at happening.start_at.to_s(:rfc822)
        xml.end_at happening.start_at.to_s(:rfc822)
        xml.open_for_registration happening.open_for_reg
        xml.open_for_proposals happening.cfp_open
        xml.sold_out happening.sold_out
      end
    end
  end
end