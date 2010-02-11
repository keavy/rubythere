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
      e.build_location if e.location.nil?
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
    date.strftime("%b %e %Y") if date
  end
  
  def event_date(start_date,end_date)
    return "" if !start_date
    output = ""
    if end_date
      if start_date.month == end_date.month
        output += start_date.strftime("%b %e")
        output += end_date.strftime("-%e %Y")
      else
        output += start_date.strftime("%b %e")
        output += end_date.strftime(" - %e %b %Y")
      end
    else
      output += start_date.strftime("%e %b % Y")
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
  
  def present_or_past(date,present,past)
    if date.nil?
      return present
    else
      if date < Time.now
        return  past
      else
        return  present
      end
    end
  end
  
  def twitter_link(name)
    return "" if name.nil?
    link_to "@#{name}", "http://twitter.com/#{name}"
  end
end
