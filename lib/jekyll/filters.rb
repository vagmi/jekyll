require 'cgi'

module Jekyll

  module Filters
    def textilize(input)
      RedCloth.new(input).to_html
    end

    def date_to_string(date)
      date.strftime("%d %b %Y")
    end

    def date_to_long_string(date)
      date.strftime("%d %B %Y")
    end

    def date_to_xmlschema(date)
      date.xmlschema
    end

    def time_to_string(date)
      date.strftime("%d %b %Y, %H:%M")
    end

    def date_to_utc(date)
      date.utc
    end

    def url_escape(input)
      CGI.escape(input)
    end

    def xml_escape(input)
      CGI.escapeHTML(input)
    end

    def number_of_words(input)
      input.split.length
    end

    # Example:
    #
    #   Posted in <span class="tags">{{ page.tags | tag_links: "example.com" }}</span>.
    #
    # Then style '.tags span { display: none; }' so the "tag:" bits don't show.
    # You can provide 'tags' as a YAML array in the post's front matter.
    def tag_links(array, domain)
      links = array.map { |tag|
        qs = %{site:#{domain} "tag: #{tag}"}
        url = "http://www.google.com/search?q=#{url_escape qs}"
        %{<a href="#{xml_escape url}"><span>tag:</span> #{xml_escape tag}</a>}
      }
      array_to_sentence_string(links)
    end

    def array_to_sentence_string(array)
      connector = "and"
      case array.length
      when 0
        ""
      when 1
        array[0].to_s
      when 2
        "#{array[0]} #{connector} #{array[1]}"
      else
        "#{array[0...-1].join(', ')}, #{connector} #{array[-1]}"
      end
    end

  end
end
