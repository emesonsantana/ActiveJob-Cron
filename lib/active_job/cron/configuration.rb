module ActiveJob
  module Cron
    module Configurable
      def configure
        yield(config)
      end

      def config
        @config ||= Configuration.new
      end
    end
    class Configuration
      attr_accessor :resolution, :utc, :handler_pool_size, :logger, :preload_jobs

      def initialize
        @resolution = 1
        @utc = false
        @preload_jobs = true
      end
    end
  end
end
