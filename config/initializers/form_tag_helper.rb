module ActionView
  module Helpers
    class InstanceTag
     
      def to_label_tag(text = nil, options = {})
        name_and_id = options.dup
        add_default_name_and_id(name_and_id)
        options["for"] = name_and_id["id"]
        content = (text.blank? ? nil : text.to_s) || method_name.humanize
        content+="<em>*</em>" if options[:required]
        options.delete(:required)
        content_tag("label", content, options)
      end
    end
  end
end
