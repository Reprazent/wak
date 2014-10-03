module Wak
  module Utils
    module Runner
      def run_command(command)
        Wak.logger.info "Running `#{command}`"
        `#{command}`
      rescue StandardError => e
        raise Wak::CommandException.new(e) unless $?.success?
      end
    end
  end
end
