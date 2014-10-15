module Wak
  module Setup
    class SetupRunner

      attr_accessor :packages
      def initialize
        @packages = [Wak::Setup::Package::Nginx.new, Wak::Setup::Package::Dnsmasq.new]
      end

      def run
        install_packages
        configure_dns
      end

      def install_packages
        packages.each do |package|
          if package.package_installed?
            Wak.logger.ok "Installed", "#{package.name} already installed"
          else
            Wak.logger.install_message "Installing #{package.name}"
            package.install!
          end
        end
      end

      def configure_dns
        Wak::Setup::DnsConfigurator.new.write!
      end

    end
  end
end
