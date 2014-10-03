module Wak
  module Setup
    module Package
      module Configuration
        class File
          attr_accessor :file

          def initialize(path)
            raise Wak::MissingConfigFile.new("The config file #{path} is missing") if !::File.exists?(path)
            @file = ::File.new(path)
          end

          def file_content
            @file_content ||= file.read.split("\n")
          end

          def build_new_config(lines, after = "")
            lines =  Array(lines)
            new_content = []
            new_content += lines if file_content.empty?
            file_content.each do |line|
              new_content << line
              new_content += lines if line.strip == after
            end
            new_content
          end

          def has_config?(lines)
            lines = Array(lines)
            (lines & file_content.map(&:strip)) == lines
          end

          def write_config(lines, after = "")
            return true if has_config?(lines)
            ::File.open(file, "w") do |f|
              f.write(build_new_config(lines, after).join("\n"))
            end
          end
        end
      end
    end
  end
end
