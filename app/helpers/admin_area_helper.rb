module AdminAreaHelper
  
  def link_to_name(event)
    if event.url.blank?
      event.name
    else
      link_to event.name, event.url, :rel => 'external'
    end
  end
end
