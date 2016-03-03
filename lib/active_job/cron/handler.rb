module ActiveJob
  module Cron
    class Handler
      include Celluloid

      def dispatch(job, time)
        if job.ready_to_perform?(time)
          ActiveJob::Cron::Lock.acquire("lock") do
            job.perform_later
          end
        end
      end
    end
  end
end
