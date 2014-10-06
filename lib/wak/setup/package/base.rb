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
          !run_command("which #{name}").nil?
        end

        def launchd_copied?
          File.exists?("/Library/LaunchDaemons/homebrew.mxcl.#{name}.plist")
        end

        def launchd_loaded?
          !run_command("launchctl list | grep #{name}").nil?
        end

        def install!(&config_block)
          run_install_command unless package_installed?
          run_copy_launchd unless launchd_copied?
          yield if block_given?
          start! unless launchd_loaded?
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
