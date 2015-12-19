module ActiveJob
  module Cron
    class Configuration
      attr_accessor :resolution, :utc
      def initialize
        @resolution = 1
        @utc = false
      end
    end
  end
end
