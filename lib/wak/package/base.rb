module Wak
  module Package
    class Base

      attr_accessor :name

      def initialize(name)
        @name = name
      end

      def package_installed?
        run_command("which #{name}") != "#{name} not found"
      end

      def install!
        return if package_installed?
        run_install_command
        run_copy_launchd
        run_load_launchd
      end

      def run_install_command
        run_command("brew install #{name}")
      end

      def run_copy_launchd
        link_command = "sudo cp -fv /usr/local/opt/#{name}/*.plist /Library/LaunchDaemons"
        run_command(link_command)
      end

      def run_load_launchd
        load_command = "sudo launchctl load /Library/LaunchDaemons/homebrew.mxcl.#{name}.plist"
        run_command(load_command)
      end

      def run_command(command)
        Wak.logger.info "Running `#{command}`"
        `#{command}`
      rescue StandardError => e
        raise Wak::CommandException.new(e) unless $?.success?
      end

    end
  end
end
