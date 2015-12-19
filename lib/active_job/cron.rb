require "celluloid"
require "ice_cube"
require "pry"

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
        Supervisor.handler
      end

      def clock
        Supervisor.clock
      end
    end
  end
end

require "active_job/cron/supervisor"

ActiveJob::Cron::Supervisor.run!
