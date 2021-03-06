require 'kramdown'

module Locomotive
  module Steam
    module Services

      class Markdown

        def to_html(text)
          return '' if text.blank?

          Kramdown::Document.new(text, auto_ids: false).to_html
        end

      end

    end
  end
end
