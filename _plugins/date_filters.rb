require "date"

module Jekyll
  module DateCustomFilter

    MONTHS = [
      nil,
      "janvier", "février", "mars", "avril", "mai", "juin",
      "juillet", "août", "septembre", "octobre", "novembre", "décembre",
    ]
    
    def date_custom(input, locale)
      
      if locale == 'en'
        formatted = date_to_string(input, "ordinal", "US")

      elsif locale == 'fr'
        
        date = input.to_date

        day = "#{date.day}"
        if date.day == 1
          day = "#{day}er"
        end

        formatted = "#{day} #{MONTHS[date.month]} #{date.year}"
        
      end

      formatted
    end
  end
end

Liquid::Template.register_filter(Jekyll::DateCustomFilter)