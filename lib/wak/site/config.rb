module Wak
  class Site
    class Config
      extend Forwardable
      attr_accessor :site
      def_delegators :@site, :path, :app_name

      def initialize(site)
        @site = site
      end
    end
  end
end
