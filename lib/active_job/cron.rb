require "celluloid"
require "ice_cube"

require "active_job/cron/generators/migration_generator"
require "active_job/cron/version"
require "active_job/cron/configuration"
require "active_job/cron/schedulable"
require "active_job/cron/trackable"
require "active_job/cron/loggable"
require "active_job/cron/clock"
require "active_job/cron/handler"

module ActiveJob
  module Cron
    extend Configurable
    extend Trackable
    extend Schedulable

    def self.included(klass)
      super

      klass.extend(ActiveJob::Cron::Schedulable)
      klass.extend(ActiveJob::Cron::Trackable)

      subclasses << klass
    end

    class << self
      def jobs
        subclasses(true).select do |job|
          job.method_defined?(:perform)
        end
      end

      def handler
        if handler = Supervisor.handler
          handler
        else
          run!
          Supervisor.handler
        end
      end

      def clock
        if clock = Supervisor.clock
          clock
        else
          run!
          Supervisor.clock
        end
      end

      def run!
        Supervisor.run!
      end
    end
  end
end

require "active_job/cron/supervisor"
require "active_job/cron/railtie"
