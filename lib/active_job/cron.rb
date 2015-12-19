require "celluloid"

require "active_job/cron/version"
require "active_job/cron/clock"
require "active_job/cron/configuration"

module ActiveJob
  module Cron
    def self.configure
      @config ||= Configuration.new
      yield(@config)
    end

    def self.config
      @config ||= Configuration.new
    end
  end
end
