module ActiveJob
  module Cron
    class Handler
      include Celluloid

      def dispatch(job, time)
        schedule = job.schedule

        return unless schedule.schedule_next?(time)

        job.perform_later
      end
    end
  end
end
