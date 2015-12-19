require 'spec_helper'

describe ActiveJob::Cron::Configuration do
  it "has default value" do
    expect(subject.resolution).to eq(1)
    expect(subject.utc).to be_falsey
    expect(subject.preload_jobs).to be_truthy
  end

  it "can be configured using right approach" do
    subject = ActiveJob::Cron
    subject.configure do |config|
      config.resolution = 10
      config.utc = true
    end

    expect(subject.config.resolution).to eq(10)
    expect(subject.config.utc).to eq(true)
  end
end
