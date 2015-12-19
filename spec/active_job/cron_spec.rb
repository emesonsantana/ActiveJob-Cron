require 'spec_helper'

describe ActiveJob::Cron do
  it 'has a version number' do
    expect(ActiveJob::Cron::VERSION).not_to be nil
  end
end
