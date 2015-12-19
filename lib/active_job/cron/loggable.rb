module ActiveJob
  module Cron
    module Loggable
      %w(fatal error warn info debug).each do |level|
        level = level.to_sym

        define_method(level) do |msg|
          if logger = ActiveJob::Cron.config.logger
            logger.__send__(level, "[ActiveJob::Cron] #{msg}")
          else
            puts "[ActiveJob::Cron] #{level}: #{msg}"
          end
        end
      end
    end
  end
end
