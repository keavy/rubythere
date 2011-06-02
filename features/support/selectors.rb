module HtmlSelectorsHelper
  def selector_for(scope)
    case scope
    when /the body/
      "html > body"
    when /the (notice|error|info) flash/
      "#flash_#{$1}"
    when /new location/
      "#new_location"
    when /existing location/
      "#existing_location"
    else
      raise "Can't find mapping from \"#{scope}\" to a selector.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(HtmlSelectorsHelper)