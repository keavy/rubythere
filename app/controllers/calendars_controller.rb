class CalendarsController < ApplicationController
  include Icalendar
  
  def show
    @cal = Calendar.new
    @happenings = Happening.approved.upcoming
    @happenings.each do |happening|
      @cal.event do
        dtstart       happening.start_at.strftime("%Y%m%d")
        dtend         happening.end_at.strftime("%Y%m%d") if happening.end_at
        summary       happening.event.name
        description   happening.description
        url           happening.url
        location      happening.location.city_state_country if happening.location
      end
    end

    @cal.publish
    send_data @cal.to_ical, :filename => "RubyThere.ics", :type => 'text/calendar'
  end
end
