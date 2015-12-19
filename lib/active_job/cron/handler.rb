module ActiveJob
  module Cron
    class Handler
      include Celluloid

      def dispatch(job, time)
        job.perform_later if job.ready_to_perform?(time)
      end
    end
  end
end
