module ActiveJob
  module Cron
    module Configurable
      def configure
        @config ||= Configuration.new
        yield(@config)
      end

      def config
        @config ||= Configuration.new
      end
    end
    class Configuration
      attr_accessor :resolution, :utc, :handler_pool_size, :logger

      def initialize
        @resolution = 1
        @utc = false
      end
    end
  end
end
