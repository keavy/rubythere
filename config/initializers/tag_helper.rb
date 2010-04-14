module ActionView
  module Helpers
    module TagHelper
      def tag(name, options = nil, open = true, escape = true)
        "<#{name}#{tag_options(options, escape) if options}#{">"}"
      end
    end
  end
end


