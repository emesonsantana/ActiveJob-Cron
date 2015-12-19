require 'spec_helper'

describe ActiveJob::Cron do
  before do
    class Job1
      include ActiveJob::Cron

      def perform
      end
    end

    class Job2
      include ActiveJob::Cron
    end
  end

  it "gets all jobs that use cron job" do
    expect(ActiveJob::Cron.jobs).to include(Job1)
  end
end
