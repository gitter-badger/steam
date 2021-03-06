require 'haml'
require 'compass'
require 'mimetype_fu'
require 'mime-types'
require 'mime/types'

require 'rack/rewrite'
require 'rack/csrf'
require 'rack/session/moneta'
require 'rack/builder'
require 'rack/lint'
require 'dragonfly/middleware'

require_relative 'middlewares'

module Locomotive::Steam
  module Server

    class << self

      def default_middlewares
        server, configuration = self, self.configuration

        -> (stack) {
          use(Rack::Rewrite) { r301 %r{^/(.*)/$}, '/$1' }
          use Middlewares::Favicon

          if configuration.serve_assets
            use ::Rack::Static, {
              root: configuration.assets_path,
              urls: ['/images', '/fonts', '/samples', '/media']
            }
            use Middlewares::DynamicAssets, {
              root:   configuration.assets_path,
              minify: configuration.minify_assets
            }
          end

          use Rack::Lint
          use Rack::Session::Moneta, configuration.moneta

          server.steam_middleware_stack.each { |k| use k }
        }
      end

      def steam_middleware_stack
        [
          Middlewares::DefaultEnv,
          Middlewares::Logging,
          Middlewares::Site,
          Middlewares::Timezone,
          Middlewares::EntrySubmission,
          Middlewares::Locale,
          Middlewares::LocaleRedirection,
          Middlewares::Path,
          Middlewares::Page,
          Middlewares::TemplatizedPage
        ]
      end

      def to_app
        stack = configuration.middleware

        Rack::Builder.new do
          stack.inject(self)

          run Middlewares::Renderer.new(nil)
        end
      end

      def configuration
        Locomotive::Steam.configuration
      end

    end

  end
end
