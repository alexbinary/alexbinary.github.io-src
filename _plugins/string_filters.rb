module Jekyll
  module UcFirstFilter
    def ucfirst(input)
      return input unless input.is_a?(String)
      input[0].upcase + input[1..-1]
    end
  end
end

Liquid::Template.register_filter(Jekyll::UcFirstFilter)
