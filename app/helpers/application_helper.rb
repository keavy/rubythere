# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def labeled_form_for(*args, &block)
    options = args.extract_options!.merge(:builder => LabeledFormBuilder)
    form_for(*(args + [options]), &block)
  end
  
  def labeled_fields_for(*args, &block)
    options = args.extract_options!.merge(:builder => LabeledFormBuilder)
    fields_for(*(args + [options]), &block)
  end
  
  def render_error_messages(*objects)
    messages = objects.compact.map { |o| o.errors.full_messages }.flatten
    render :partial => 'shared/error_messages', :object => messages unless messages.empty?
  end
  
  def setup_event(event)
    returning(event) do |e|
      e.build_submitter if e.submitter.nil?
      e.happenings.build if e.happenings.blank?
      e.happenings.each do |h|
        h.build_location if h.location.nil?
      end
    end
  end
  
  def setup_happening(happening)
    returning(happening) do |h|
      h.build_location if h.location.nil?
    end
  end
  
  def setup_presentation(presentation)
    returning(presentation) do |e|
      e.build_talk if e.talk.nil?
      e.build_speaker if e.speaker.nil?
    end
  end
  
  def display_location(location)
    output = ""
    unless location.nil?
      output += "#{location.city}, " unless location.city.blank?
      output += "#{location.state}, " unless location.state.blank?
      output += "#{location.country}"
    end
    return output
  end
  
  def city_state(location)
    output = ""
    unless location.nil?
      output += "#{location.city}" unless location.city.blank?
      output += ", #{location.state}" unless location.state.blank?
    end
    return output
  end
  
  def format_date(date)
    return '' if date.nil?
    if Time.now.year == date.year
      date.strftime("%b %e")
    else
      date.strftime("%b %e %Y")
    end
  end
  
  def event_date(start_date,end_date)
    return "" if !start_date
    output = ""
    if end_date
      if start_date.month == end_date.month
        output += start_date.strftime("%b %e")
        output += (Time.now.year == start_date.year) ? end_date.strftime("-%e") : end_date.strftime("-%e %Y")
      else
        output += start_date.strftime("%b %e")
        output += (Time.now.year == start_date.year) ? end_date.strftime(" - %e %b") : end_date.strftime(" - %e %b %Y")
      end
    else
      output += (Time.now.year == start_date.year) ? start_date.strftime("%e %b") : start_date.strftime("%e %b %Y")
    end
    return output
  end
  
  def been_and_gone?(date)
    case true
    when date.nil? then 'unknown'
    when date < Time.now then "past"
    else 'upcoming'
    end
  end
  
  def twitter_link(name)
    return "" if name.nil?
    link_to "@#{name}", "http://twitter.com/#{name}"
  end
  
  def link_to_showing_current(text,path,default=false)
    if (request.path == path) || (request.path == '/' && default)
      cl = 'active'
    end
    "<li class='#{cl}'>#{link_to text, path}</li>"
  end

  def cross_or_tick(value)
    if value
      image_tag 'tick.gif'
    else
      image_tag 'cross.gif'
    end
  end
end
