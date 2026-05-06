require "date"

module Jekyll
  module DateWithLocaleFilter
    MONTHS = {
      "fr" => %w[janvier février mars avril mai juin juillet août septembre octobre novembre décembre]
    }
  
    def date_with_locale(input, format, locale)
      
      formatted = input.to_date.strftime(format)
      
      if locale != 'en' && (format.include?("%B") || format.include?("%b"))
        MONTHS[locale].each_with_index do |month, i|
          en_month = Date::MONTHNAMES[i + 1]
          formatted.gsub!(en_month, month)
        end
      end
      
      formatted
    end
  end
end

Liquid::Template.register_filter(Jekyll::DateWithLocaleFilter)