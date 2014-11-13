module Wak
  module Setup
    module Package
      def self.nginx
        Wak::Setup::Package::Nginx.new
      end

      def self.dnsmasq
        Wak::Setup::Package::Dnsmasq.new
      end
    end
  end
end
