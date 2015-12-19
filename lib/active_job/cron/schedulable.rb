module ActiveJob
  module Cron
    module Schedulable
      attr_reader :last_occurrence

      def ready_to_perform?(time)
        next_occurrence = schedule.next_occurrence(time).to_i
        # See IceCube's document about how #next_occurrence works
        if next_occurrence != last_occurrence
          @last_occurrence = next_occurrence
          true
        else
          false
        end
      end

      def schedule
        @schedule ||= IceCube::Schedule.new
      end

      def recurrence
        yield
      end

      def method_missing(meth, *args, &block)
        if IceCube::Rule.respond_to?(meth)
          rule = IceCube::Rule.send(meth, *args, &block)
          schedule.add_recurrence_rule(rule)
          rule
        elsif schedule.respond_to?(meth)
          schedule.send(meth, *args, &block)
        else
          super
        end
      end
    end
  end
end
