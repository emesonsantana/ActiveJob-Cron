require "spec_helper"

describe ActiveJob::Cron::Schedulable do
  class SampleJob
    extend ActiveJob::Cron::Schedulable
  end

  subject { SampleJob }

  describe ".recurrence" do
    before do
      subject.instance_variable_set(:@schedule, nil)
    end

    it "sets recurrence rule to ice_cube schedule" do
      subject.class_eval do
        recurrence { hourly }
      end

      first_occurrence = subject.schedule.first.to_i
      second_occurrence = subject.schedule.first(2)[-1].to_i

      frequency = second_occurrence - first_occurrence
      expect(frequency).to eq(3600)
    end
  end

  describe ".ready_to_perform?" do
    it "returns true if last_occurrence is not equal to next_occurrence" do
      next_occurrence = 100
      last_occurrence = 99
      schedule = double("schedule")

      expect(subject).to receive(:schedule) { schedule }
      expect(subject).to receive(:last_occurrence) { last_occurrence }
      expect(schedule).to receive_message_chain(:next_occurrence, :to_i) { next_occurrence }

      expect(subject.ready_to_perform?(Time.now)).to be_truthy
      expect(subject.instance_variable_get(:@last_occurrence)).to eq(next_occurrence)
    end
    it "returns false if last_occurrence is equal to next_occurrence" do
      next_occurrence = 100
      last_occurrence = 100
      schedule = double("schedule")

      expect(subject).to receive(:schedule) { schedule }
      expect(subject).to receive(:last_occurrence) { last_occurrence }
      expect(schedule).to receive_message_chain(:next_occurrence, :to_i) { next_occurrence }

      expect(subject.ready_to_perform?(Time.now)).to be_falsey
      expect(subject.instance_variable_get(:@last_occurrence)).to eq(last_occurrence)
    end
  end
end
