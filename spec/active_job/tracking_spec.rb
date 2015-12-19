require 'spec_helper'

describe ActiveJob::Cron do
  before do
    class Worker1
      include ActiveJob::Cron

      def perform
      end
    end

    class Worker2
      include ActiveJob::Cron
    end
  end

  it "gets all workers that use cron job" do
    expect(ActiveJob::Cron.workers).to include(Worker1)
  end
end
