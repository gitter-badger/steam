module Locomotive
  module Steam
    module Repositories
      module Filesystem
        module MemoryAdapter

          class SimpleCacheStore

            @@store = {}

            def fetch(name, options = nil, &block)
              if block_given?
                read(name) || write(name, yield)
              else
                read(name)
              end
            end

            def read(name, options = nil)
              @@store[name]
            end

            def write(name, value, options = nil)
              @@store[name] = value
            end

            def clear
              @@store.clear
            end

            #:nocov:
            def _store
              @@store
            end

          end

        end
      end
    end
  end
end
