module Wak
  module Setup
    module Package
      class Base
        include Wak::Utils::Runner
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
          yield if block_given?
          start!
        end

        def start!
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

      end
    end
  end
end
