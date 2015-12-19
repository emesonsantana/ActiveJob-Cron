module ActiveJob
  module Cron
    class Clock
      include Celluloid
      attr_reader :schedules

      def initialize # :nodoc:
        super
        after(0) do
          debug "ActiveHob::Cron looping ..."
          loop!
        end
      end

      # Public: Get the schedule for `worker`.
      #
      # worker - A Sidekiq::Worker class
      #
      # Examples
      #
      #   schedule_for(MyWorker)
      #   # => Sidetiq::Schedule
      #
      # Returns a Sidetiq::Schedule instances.
      def schedule_for(worker)
        if worker.respond_to?(:schedule)
          worker.schedule
        end
      end

      # Public: Issue a single clock tick.
      #
      # Examples
      #
      #   tick
      #   # => Hash of Sidetiq::Schedule objects
      #
      # Returns a hash of Sidetiq::Schedule instances.
      def tick(tick = gettime)
        ActiveJob::Cron.workers.each do |worker|
          ActiveJob::Cron.handler.dispatch(worker, tick)
        end
      end

      # Public: Returns the current time used by the clock.
      #
      # Examples
      #
      #   gettime
      #   # => 2013-02-04 12:00:45 +0000
      #
      # Returns a Time instance.
      def gettime
        ActiveJob::Cron.config.utc ? Time.now.utc : Time.now
      end

      private

      def loop!
        after([time { tick }, 0].max) do
          loop!
        end
      rescue StandardError => e
        raise e
      end

      def time
        start = gettime
        yield
        ActiveJob::Cron.config.resolution - (gettime.to_f - start.to_f)
      end
    end
  end
end
