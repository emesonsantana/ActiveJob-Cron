require "celluloid"

require "active_job/cron/version"
require "active_job/cron/clock"
require "active_job/cron/schedulable"
require "active_job/cron/trackable"
require "active_job/cron/configuration"

require "pry"

module ActiveJob
  module Cron
    extend Trackable

    def self.included(klass)
      super

      klass.extend(ActiveJob::Cron::Schedulable)
      klass.extend(ActiveJob::Cron::Trackable)

      subclasses << klass
    end

    class << self
      def workers
        subclasses(true).select do |worker|
          worker.method_defined?(:perform)
        end
      end

      def configure
        @config ||= Configuration.new
        yield(@config)
      end

      def config
        @config ||= Configuration.new
      end
    end
  end
end
