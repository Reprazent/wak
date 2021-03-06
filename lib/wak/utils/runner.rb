module Wak
  module Utils
    module Runner
      def run_command(command)
        Wak.logger.command command
        output = []
        IO.popen(command) do |io|
          while(line = io.gets) do
            Wak.logger.output line.chomp!
            output << line
          end
          io.close
        end
        output.last
      rescue StandardError => e
        raise Wak::CommandException.new(e) unless $?.success?
      end
    end
  end
end
