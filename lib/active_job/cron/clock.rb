module ActiveJob
  module Cron
    class Clock
      include Celluloid
      include Loggable
      attr_reader :schedules

      def initialize # :nodoc:
        super
        after(0) do
          debug "ActiveHob::Cron looping ..."
          loop!
        end
      end

      # Get the schedule for `job`.
      def schedule_for(job)
        if job.respond_to?(:schedule)
          job.schedule
        end
      end

      # Tick a single clock.
      def tick(time = gettime)
        ActiveJob::Cron.jobs.each do |job|
          ActiveJob::Cron.handler.dispatch(job, time)
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
