require "celluloid"
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
    end
  end
end

require "active_job/cron/supervisor"

ActiveJob::Cron::Supervisor.run!
