module ActiveJob
  module Cron
    class Handler
      include Celluloid

      def dispatch(worker, time)
      end
    end
  end
end
