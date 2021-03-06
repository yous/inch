require 'json'
require 'inch/language/nodejs/provider/jsdoc/object'

module Inch
  module Language
    module Nodejs
      module Provider
        module JSDoc
          # Parses the source tree (using JSDoc)
          class Parser
            attr_reader :parsed_objects

            # Helper method to parse an instance with the given +args+
            #
            # @see #parse
            # @return [CodeObject::Provider::JSDoc::Parser] the instance that
            #   ran
            def self.parse(*args)
              parser = new
              parser.parse(*args)
              parser
            end

            # @param dir [String] directory
            # @param config [Inch::Config::Codebase] configuration for codebase
            # @return [void]
            def parse(dir, config)
              Dir.chdir(dir) do
                parse_objects(config.included_files, config.excluded_files,
                              config.read_dump_file)
              end
            end

            # @return [Array<YARD::Object::Base>]
            def objects
              pp @parsed_objects[10]
              @objects ||= parsed_objects.map do |o|
                JSDoc::Object.for(o) # unless IGNORE_TYPES.include?(o.type)
              end.compact
              puts "#{@objects.size} objects found."
              puts 'Rest of implementation: coming soon -.-'
              exit 1
            end

            private

            def parse_objects(paths, excluded, read_dump_file = nil)
              if read_dump_file.nil?
                output = `jsdoc --explain #{paths.join(' ')}`
              else
                output = File.read(read_dump_file)
              end
              @parsed_objects = JSON[output]
            end
          end
        end
      end
    end
  end
end
