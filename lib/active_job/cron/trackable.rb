module ActiveJob
  module Cron
    module Trackable
      def subclasses(deep = false)
        @subclasses ||= []

        if deep
          @subclasses.inject([]) do |all, subclass|
            (all << subclass) + subclass.subclasses(true)
          end
        else
          @subclasses
        end
      end

      def inherited(klass)
        super
        subclasses << klass
      end
    end
  end
end
