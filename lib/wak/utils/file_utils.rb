module Wak
  module Utils
    module FileUtils

      attr_accessor :file

      def file_content
        @file_content ||= file.read.split("\n")
      end

      def contains_lines?(lines)
        lines = Array(lines)
        (lines & file_content.map(&:strip)) == lines
      end

    end
  end
end
