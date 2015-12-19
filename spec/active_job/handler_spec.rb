require "spec_helper"

describe ActiveJob::Cron::Handler do
  describe "#dispatch" do
    it "performs job if it's ready" do
      job = double("job")
      allow(job).to receive(:ready_to_perform?).and_return(true)
      allow(job).to receive(:perform_later)

      subject.dispatch(job, Time.now)

      expect(job).to have_received(:perform_later)
    end
    it "does nothing if a job is not ready" do
      job = double("job")
      allow(job).to receive(:ready_to_perform?).and_return(false)
      allow(job).to receive(:perform_later)

      subject.dispatch(job, Time.now)

      expect(job).not_to have_received(:perform_later)
    end
  end
end
