module Locomotive
  module Steam
    module Liquid
      module Drops
        class I18nBase < Base

          def initialize(source, localized_attributes = nil)
            # puts "creating #{self.class.name} drop for #{source.class.name}(#{source.object_id.inspect})"
            decorated = source if source.respond_to?(:__locale__)
            decorated ||= Locomotive::Steam::Decorators::I18nDecorator.new(source, localized_attributes)
            super(decorated)
          end

          def context=(context)
            # puts "context=... #{self.class.name} / #{@_source.attributes.inspect} / #{@_source.__getobj__.object_id.inspect}"
            # puts "locale=#{context.registers[:locale].inspect}"
            if locale = context.registers[:locale]
              @_source.__locale__ = locale
            end

            @_source.__default_locale__ = context.registers[:site].try(:default_locale)

            super
          end

          private

          def _change_locale(locale)
            @_source.__locale__ = locale
          end

          def _change_locale!(locale)
            @_source.__locale__ = locale
            @_source.__freeze_locale__
          end

        end
      end
    end
  end
end
