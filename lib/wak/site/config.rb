require "mustache"
module Wak
  class Site
    class Config < Mustache
      extend Forwardable
      attr_accessor :site
      def_delegators :@site, :path, :app_name

      def initialize(site)
        @site = site
      end
    end
  end
end
