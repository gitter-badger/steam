module Locomotive
  module Steam
    module Liquid
      module Tags
        class Extends < ::Liquid::Extends

          private

          def parse_parent_template
            parent = options[:parent_finder].find(options[:page], @template_name)

            # no need to go further if the parent does not exist
            raise PageNotFound.new("Page with fullpath '#{@template_name}' was not found") if parent.nil?

            if listener = options[:events_listener]
              listener.emit(:extends, page: options[:page], parent: parent)
            end

            # the source has already been parsed before
            options[:parser]._parse(parent, options.merge(page: parent))
            # parent.template || ::Liquid::Template.parse(parent.source, options.merge(page: parent))
          end

        end

        ::Liquid::Template.register_tag('extends'.freeze, Extends)
      end
    end
  end
end

# def prepare_parsing
          #   super

          #   parent_page = @context[:parent_page]

          #   @context[:page].merge_editable_elements_from_page(parent_page)

          #   @context[:snippets] = parent_page.snippet_dependencies
          #   @context[:templates] = ([*parent_page.template_dependencies] + [parent_page.id]).compact
          # end

# if @template_name == 'parent'
            #   @context[:parent_page] = @context[:cached_parent] || @context[:page].parent
            # else
            #   locale = ::Mongoid::Fields::I18n.locale

            #   @context[:parent_page] = @context[:cached_pages].try(:[], @template_name) ||
            #     @context[:site].pages.where("fullpath.#{locale}" => @template_name).first
            # end

            # raise PageNotFound.new("Page with fullpath '#{@template_name}' was not found") if @context[:parent_page].nil?

            # # be sure to work with a copy of the parent template otherwise there will be conflicts
            # parent_template = @context[:parent_page].template.try(:clone)

            # raise PageNotTranslated.new("Page with fullpath '#{@template_name}' was not translated") if parent_template.nil?

            # # force the page to restore the original version of its template (from the serialized version)
            # @context[:parent_page].instance_variable_set(:@template, nil)

            # parent_template
