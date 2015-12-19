require "rails"

module ActiveJob
  module Cron
    class Railtie < Rails::Railtie
      config.after_initialize do
        ActiveJob::Cron.config.logger = Rails.logger

        Dir.glob(Rails.root + "app/jobs/*_job*.rb").each do |c|
          require_dependency(c)
        end if ActiveJob::Cron.config.preload_jobs

        ActiveJob::Cron.run!
      end
    end
  end
end
